require 'date'

module OMGSeq
  class Sample
    class << self
      def load_data(fpath)
        open(fpath).readlines.drop(1).map do |line|
          line.chomp.split("\t")
        end
      end
    end

    def initialize(data)
      @data = self.class.load_data(data)
      @submission = create_submission
    end

    def create_submission
      @data.map{|entry| create_biosample(entry).join("\t") }
    end

    def data_header
      [
        "label_id.web",
        "Sample_Name",
        "I7_Index_ID",
        "index",
        "I5_Index_ID",
        "index2",
        "Run",
        "sampling_date.web",
        "latlong.web.curated",
        "sampling_location.web",
        "sampling_location.web.curated",
        "sampling_location.web.curated.eng",
        "metadata.web",
        "days_since_blooming.web",
        "sampling_date.paper",
        "sampling_location.paper",
        "metadata.paper",
        "気温(℃)",
        "降水量(mm)",
        "日照時間(時間)",
        "風速(m/s)",
        "風向",
        "日射量(MJ/㎡)",
        "相対湿度(％)",
      ]
    end

    def create_biosample(entry)
      object = create_biosample_object(entry)
      biosample_header.map{|field| object[field.to_sym] }
    end

    def create_biosample_object(entry)
      label    = entry[1].split("_")[0]
      date     = entry[7] ? DateTime.parse(entry[7]).strftime("%Y/%m/%d") : "2015"
      latlon   = entry[8] || "NA"
      location = entry[11] || "Japan"

      air_temp_regm  = entry[17] ? entry[17] + "˚C" : ""
      rainfall_regm  = entry[18] ? entry[18] + "mm" : ""
      radiation_regm = entry[19] ? entry[19] + "MJ/m^2" : ""
      humidity_regm  = entry[23] ? entry[23] + "%" : ""

      {
        # required - data
        sample_name: "omgseq_" + label,
        sample_title: "16S Sequencing of microbiome on flower of genus Prunus in " + location + ", label number " + label,
        collection_date: date,
        geo_loc_name: location,
        lat_lon: latlon,

        # required - fixed
        organism: "flower metagenome",
        taxonomy_id: "1385665",
        env_biome: "terrestrial biome",
        env_feature: "organic feature",
        env_material: "organic material",
        project_name: "Ohanami Metagenome Project",
        host: "Prunus",
        plant_body_site: "petal",

        # option data
        elev: "",
        air_temp_regm: air_temp_regm,
        rainfall_regm: rainfall_regm,
        radiation_regm: radiation_regm,
        humidity_regm: humidity_regm,

        # option fixed
        bioproject_id: "",
        strain: "unidentified",
        breed: "unidentified",
        cultivar: "unidentified",
        host_common_name: "Cherry",
        host_taxid: "3754",
        life_stage: "Floweing stage",
        samp_store_temp: "-80˚C",
        season_environment: "Spring",
      }
    end

    def biosample_header
      [
        "sample_name",
        "sample_title",
        "description",
        "organism",
        "taxonomy_id",
        "bioproject_id",
        "strain",
        "breed",
        "cultivar",
        "isolate",
        "label",
        "biomaterial_provider",
        "collection_date",
        "env_biome",
        "env_feature",
        "env_material",
        "geo_loc_name",
        "lat_lon",
        "project_name",
        "host",
        "rel_to_oxygen",
        "samp_collect_device",
        "samp_mat_process",
        "sample_size",
        "depth",
        "elev",
        "altitude",
        "age",
        "air_temp_regm",
        "antibiotic_regm",
        "body_product",
        "chem_administration",
        "chem_mutagen",
        "climate_environment",
        "dry_mass",
        "fertilizer_regm",
        "fungicide_regm",
        "gaseous_environment",
        "genotype",
        "gravity",
        "growth_hormone_regm",
        "growth_med",
        "height_or_length",
        "herbicide_regm",
        "host_common_name",
        "host_disease_stat",
        "host_taxid",
        "humidity_regm",
        "infra_specific_name",
        "infra_specific_rank",
        "life_stage",
        "mechanical_damage",
        "mineral_nutr_regm",
        "misc_param",
        "non_mineral_nutr_regm",
        "organism_count",
        "oxy_stat_samp",
        "perturbation",
        "pesticide_regm",
        "ph_regm",
        "phenotype",
        "plant_body_site",
        "plant_product",
        "radiation_regm",
        "rainfall_regm",
        "salt_regm",
        "samp_salinity",
        "samp_store_dur",
        "samp_store_loc",
        "samp_store_temp",
        "season_environment",
        "standing_water_regm",
        "temp",
        "tiss_cult_growth_med",
        "tot_mass",
        "water_temp_regm",
        "watering_regm",
        "wet_mass",
      ]
    end
  end
end
