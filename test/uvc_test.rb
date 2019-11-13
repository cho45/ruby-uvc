require "test_helper"

class UVCTest < Minitest::Test
	def test_that_it_has_a_version_number
		refute_nil ::UVC::VERSION
	end

	def test_devices
		refute_nil UVC::UVCDevice.devices
	end
end
