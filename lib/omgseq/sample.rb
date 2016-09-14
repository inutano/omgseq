require 'date'

module OMGSeq
  class Sample
    def initialize(sample)
      @sample = sample

      @label     = @sample[1]
      @date      = @sample[7]  || ""
      @latlon    = @sample[8]  || ""
      @location  = @sample[11] || ""
      @dsb       = @sample[13] || ""
      @air_temp  = @sample[17] || ""
      @rainfall  = @sample[18] || ""
      @radiation = @sample[19] || ""
      @humidity  = @sample[23] || ""
    end

    def submission
      {
        # required - data
        sample_name:     "omgseq_" + label,
        sample_title:    title,
        collection_date: date,
        geo_loc_name:    location,
        lat_lon:         latlon,
        # required - fixed
        organism:        "flower metagenome",
        taxonomy_id:     "1385665",
        env_biome:       "terrestrial biome",
        env_feature:     "organic feature",
        env_material:    "organic material",
        project_name:    "Ohanami Metagenome Project",
        host:            "Prunus",
        plant_body_site: "petal",
        # option data
        elev:           elev,
        air_temp_regm:  air_temp_regm,
        rainfall_regm:  rainfall_regm,
        radiation_regm: radiation_regm,
        humidity_regm:  humidity_regm,
        misc_param:     days_since_blooming,
        # option fixed
        host_common_name:   "Cherry blossom",
        host_taxid:         "3754",
        life_stage:         "Floweing stage",
        season_environment: "Spring",
        strain:             "unidentified",
        breed:              "unidentified",
        cultivar:           "unidentified",
      }
    end

    def supplementary
      {
        sample_name: label,
        collection_date: date.sub(/T/,"\s"),
        geo_loc_name: location == "Japan" ? location : location.sub(/Japan:/,"").sub(/$/,", Japan"),
        lat_lon: latlon,
        air_temp_regm: air_temp_regm ? air_temp_regm.sub(/oC/,"˚C") : "not collected",
        humidity_regm: humidity_regm || "not collected",
        rainfall_regm: rainfall_regm || "not collected",
        radiation_regm: radiation_regm ? radiation_regm.sub(/Sunlight:/,"") : "not collected",
      }
    end

    protected

    def label
      @label.split("_")[0]
    end

    def title
      head = "16S Sequencing of microbiome on flower of genus Prunus"
      loc  = @location.empty? ? "" : " in #{@location}"
      lab  = ", label number #{label}"
      head + loc + lab
    end

    def date
      if @date.empty?
        "2015"
      else
        DateTime.parse(@date).strftime("%Y-%m-%dT%H:%M:%S")
      end
    end

    def location
      if @location.empty?
        "Japan"
      else
        "Japan:" + @location.split(", ").reverse.join(", ")
      end
    end

    def latlon
      if @latlon.empty?
        "not collected"
      else
        ll = @latlon.gsub(/\s/,"").split(",").map{|v| v.to_f }
        n = "%0.4f" % ll[0]
        e = "%0.4f" % ll[1]
        "#{n} N #{e} E"
      end
    end

    def elev
      if !@latlon.empty?
        ll = @latlon.gsub(/\s/,"").split(",").map{|v| v.to_f }
        if ll[2]
          ("%0.2f" % ll[2]).to_s + "m"
        end
      end
    end

    def air_temp_regm
      if !@air_temp.empty?
        ("%0.1f" % @air_temp.to_f).to_s + " oC"
      end
    end

    def rainfall_regm
      if !@rainfall.empty?
        ("%0.1f" % @rainfall.to_f).to_s + " mm"
      end
    end

    def radiation_regm
      if !@radiation.empty?
        "Sunlight:" + ("%0.1f" % @radiation.to_f).to_s + " MJ/m^2"
      end
    end

    def humidity_regm
      if !@humidity.empty?
        ("%0.1f" % @humidity.to_f).to_s + " %"
      end
    end

    def days_since_blooming
      if !@dsb.empty?
        "Days_since_blooming: #{@dsb} days"
      end
    end
  end
end
