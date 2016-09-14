module OMGSeq
  class Table
    def initialize(fpath)
      @data = open(fpath).readlines.drop(1).map{|line| line.chomp.split("\t") }
    end

    def create_submission
      submission_data = @data.map do |d|
        obj = Sample.new(d).submission
        submission_column.map{|col| obj[col.intern] }.join("\t")
      end
      submission_data.unshift(submission_header.join("\t"))
    end

    def create_supplementary
      supplementary_data = @data.map do |d|
        obj = Sample.new(d).supplementary
        supplementary_column.map{|col| obj[col.intern] }.join("\t")
      end
      supplementary_data.unshift(supplementary_header.join("\t"))
    end

    def submission_header
      [
        "*sample_name",
        "*sample_title",
        "description",
        "*organism",
        "*taxonomy_id",
        "bioproject_id",
        "strain",
        "breed",
        "cultivar",
        "isolate",
        "label",
        "biomaterial_provider",
        "*collection_date",
        "*env_biome",
        "*env_feature",
        "*env_material",
        "*geo_loc_name",
        "*lat_lon",
        "*project_name",
        "*host",
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

    def submission_column
      submission_header.map{|str| str.sub(/\*/,"") }
    end

    def supplementary_header
      [
        "Sample ID",
        "Collection date",
        "Geological location name",
        "Latitude/Longtitude",
        "Days since blooming",
        "Air temperature (˚C)",
        "Humidity (%)",
        "Rainfall (mm)",
        "Sunlight (MJ/m^2)",
      ]
    end

    def supplementary_column
      [
        "sample_name",
        "collection_date",
        "geo_loc_name",
        "lat_lon",
        "days_since_blooming",
        "air_temp_regm",
        "humidity_regm",
        "rainfall_regm",
        "radiation_regm",
      ]
    end
  end
end
