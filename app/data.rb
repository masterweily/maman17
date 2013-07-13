require 'yaml'
require 'yw_aima'
module App::Data

  PATH = 'data/yml'
  EXAMPLES_PATH = "#{PATH}/examples.yml"
  Example = YW_AIMA::Learning::Decision::Example

  def self.examples
    YAML.load_file(EXAMPLES_PATH).map do |data|

      Example.new(data['attributes'],data['decision'])
    end
  end

end