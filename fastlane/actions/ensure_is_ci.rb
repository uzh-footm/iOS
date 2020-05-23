module Fastlane
  module Actions
    module SharedValues
      ENSURE_IS_CI_CUSTOM_VALUE = :ENSURE_IS_CI_CUSTOM_VALUE
    end

    class EnsureIsCiAction < Action
      def self.run(params)
        unless other_action.is_ci
          UI.user_error! "Lane '" + ENV["FASTLANE_PLATFORM_NAME"] + " " + ENV["FASTLANE_LANE_NAME"] + "' needs to run on a CI server."
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Ensure that this action is ran on a CI server."
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "This action makes sure the 'is_ci' action returns true, otherwise the lane is stopped."
      end

      def self.authors
        ["dvdblk"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
