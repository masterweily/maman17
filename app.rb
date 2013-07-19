$: << 'lib'
$: << '.'
require 'yw_aima'

module App
  extend ActiveSupport::Autoload

  autoload :Data

  examples = Data.examples

end



