$: << 'lib'
$: << '.'
require 'yw_aima'
require 'awesome_print'

module App
  extend ActiveSupport::Autoload

  autoload :Data
  Learner = YW_AIMA::Learning::Decision::Learner

  def self.run
    puts 'Loading Examples...'
    examples = Data.examples
    puts 'Learning...'
    tree = Learner.tree_learn(examples)
    puts 'Generated Tree:'
    ap tree.to_hash

    begin
      file_name = "outputs/#{Time.now.to_i}_tree.yml"
      File.open(file_name, 'w') { |file| file.write(tree.to_hash.to_yaml) }
      puts "Tree saved to: #{file_name}"
    rescue
    end

    puts '---------------------------------------------------'
    query = Data.query_examples.first
    results = {}
    examples.map{ |example| example.attributes['Location']}.uniq.each do |location|
      query.attributes['Location'] = location
      puts 'Quering the tree, query:'
      ap query.attributes.to_hash
      result = tree.classify query
      results[result] ||= 0
      results[result] += 1
      puts "Result: #{result}"
      puts '---------------------------------------------------'
    end

    puts 'Summary:'
    ap results



  end
end




