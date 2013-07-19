#
# gererator script
#
# generate data yml file from raw data txt file
#
#
require './text_parser'
require 'yaml'
module Generators

  module Data
    DATA_PATH = '../data'
    TXT_PATH = "#{DATA_PATH}/txt"
    YML_PATH = "#{DATA_PATH}/yml"

    def self.samples_txt_to_yml file_name,decision_key
      samples = format_samples txt_table_to_hash(file_name),decision_key
      save_as_yaml samples,file_name
    end


    private
    def self.txt_path file_name
      "#{TXT_PATH}/#{file_name}.txt"
    end

    def self.yml_path file_name
      "#{YML_PATH}/#{file_name}.yml"
    end


    def self.save_as_yaml hash,file_name
      yaml = hash.to_yaml.gsub("'",'')
      file = File.new(yml_path(file_name), 'w')
      file.write(yaml)
      file.close
    end


    def self.format_samples samples,decision_key
      samples.map{ |sample| format_sample(sample,decision_key) }
    end

    def self.format_sample sample,decision_key
    {
        'decision' => sample.delete(decision_key.to_s),
        'attributes' => sample
    }

    end


    def self.txt_table_to_hash file_name
      txt = File.read txt_path(file_name)
      TextParser.parse_table(txt)
    end


  end

end


file_name = 'examples'
decision_key = :Enjoy


Generators::Data.samples_txt_to_yml file_name,decision_key

