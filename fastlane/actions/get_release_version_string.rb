module Fastlane
  module Actions
    module SharedValues
      GET_RELEASE_VERSION_STRING_CUSTOM_VALUE = :GET_RELEASE_VERSION_STRING_CUSTOM_VALUE
    end

    class GetReleaseVersionStringAction < Action
      def self.run(params)
        # Get Version and Build Number
        version = other_action.get_version_number(
          xcodeproj: xcodeproj,
          target: target
        )

        build_number = other_action.get_build_number(
          xcodeproj: xcodeproj
        )
        
        # Return new branch name
        release_version_string = "v" + version + "b" + build_number
        ENV["RELEASE_VERSION_STRING"] = release_version_string
        return release_version_string
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Creates a standard iOS app version string. (e.g. 'v1.0.0b1337')"
      end

      def self.details
        "This action should be used whenever the proper format of the version is needed. For instance, when there is a new 'release/' branch or a release tag."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                       description: "The Xcode project used to fetch the version + build number.",
                                       verify_block: proc do |value|
                                          UI.user_error!("No Xcode project name for GetReleaseVersionStringAction given, pass using `xcodeproj_name: 'name'`") unless (value and not value.empty?)
                                          UI.user_error!("Couldn't find project '#{value}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :target,
                                       description: "The Target which is used to get the App version.",
                                       is_string: true)
        ]
      end

      def self.output
        [
          ['RELEASE_VERSION_STRING', 'This value contains the release version string.']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["dvdblk"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
