$: << 'lib'
$: << '.'
require 'yw_aima'

module App
  extend ActiveSupport::Autoload

  autoload :Data

  Data.examples.map(&:attributes)

end



