module PipedriveRuby
# Recent changes across all item types in Pipedrive (deals, persons, etc).
  class Recents < PipedriveRuby::Base
    def_delegators :endpoints, :all
  end
end
