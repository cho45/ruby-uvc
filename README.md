# UVC

Parse Descriptor for UVC (USB Video Class)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uvc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uvc

## Usage

```ruby
# returns libusb Device class instance
# ref. https://rubydoc.info/gems/libusb/LIBUSB/Device
p UVC::UVCDevice.devices

# libusb Setting class instance
# ref. https://rubydoc.info/gems/libusb/LIBUSB/Setting
setting = UVC::UVCDevice.video_control_interface_settings_of(UVC::UVCDevice.devices.first).first

# Create UVCDevice instance with libusb Setting instance
uvc = UVC::UVCDevice.new(setting)

# ct is Camera Terminal
ct = uvc.camera_terminals.first
# pu is Processing Unit
pu = uvc.processing_units.first

# print all descriptors of UVC
pp uvc.descriptors

# Include module for using control constants (eg. CT_AE_MODE_CONTROL)
include UVC::Controls

# Open and claim interface for video control subclass interface.
uvc.open do
	# show some control values
	[
		CT_SCANNING_MODE_CONTROL,
		CT_AE_MODE_CONTROL,
		CT_AE_PRIORITY_CONTROL,
		CT_EXPOSURE_TIME_ABSOLUTE_CONTROL,

		PU_BACKLIGHT_COMPENSATION_CONTROL,
		PU_BRIGHTNESS_CONTROL,
		PU_CONTRAST_CONTROL,
		PU_CONTRAST_AUTO_CONTROL,
		PU_GAIN_CONTROL,
		PU_POWER_LINE_FREQUENCY_CONTROL,
		PU_HUE_CONTROL,
		PU_HUE_AUTO_CONTROL,
		PU_SATURATION_CONTROL,
		PU_SHARPNESS_CONTROL,
		PU_GAMMA_CONTROL,
		PU_WHITE_BALANCE_TEMPERATURE_CONTROL,
		PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL,
		PU_DIGITAL_MULTIPLIER_CONTROL,
		PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL,
	].each do |control|
		target = nil
		case control.to_s
		when /^CT/
			target = ct
		when /^PU/
			target = pu
		else
			raise "unknown"
		end

		# For controls known from the specification, the values are decoded.
		cur = uvc.get_cur(control, target.bUnitID) rescue nil
		res = uvc.get_res(control, target.bUnitID) rescue nil
		max = uvc.get_max(control, target.bUnitID) rescue nil
		min = uvc.get_min(control, target.bUnitID) rescue nil
		dff = uvc.get_def(control, target.bUnitID) rescue nil
		p [control, [:min, min, :cur, cur, :max, max, :def, dff, :res, res]]
	end

	# Set some values for CT control
	p uvc.set_cur(CT_AE_MODE_CONTROL, ct.bUnitID, 1) # exposure manual
	p uvc.set_cur(CT_EXPOSURE_TIME_ABSOLUTE_CONTROL, ct.bUnitID, 600)

	# Set some values for PU control
	p uvc.set_cur(PU_BACKLIGHT_COMPENSATION_CONTROL, pu.bUnitID, 0)
	p uvc.set_cur(PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL, pu.bUnitID, false)
	p uvc.set_cur(PU_WHITE_BALANCE_TEMPERATURE_CONTROL, pu.bUnitID, 5000)
	p uvc.set_cur(PU_GAIN_CONTROL, pu.bUnitID, 80)
	p uvc.set_cur(PU_GAMMA_CONTROL, pu.bUnitID, 120)
	p uvc.set_cur(PU_POWER_LINE_FREQUENCY_CONTROL, pu.bUnitID, 0)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cho45/uvc.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

