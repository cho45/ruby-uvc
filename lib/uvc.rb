require "uvc/version"

require "libusb"
require 'stringio'

module UVC
	# https://www.usb.org/document-library/video-class-v15-document-set
	CC_VIDEO = 0x0e

	SC_UNDEFINED = 0x00
	SC_VIDEOCONTROL = 0x01
	SC_VIDEOSTREAMING = 0x02
	SC_VIDEO_INTERFACE_COLLECTION = 0x03

	PC_PROTOCOL_UNDEFINED = 0x00
	PC_PROTOCOL_15 = 0x01

	CS_UNDEFINED = 0x20
	CS_DEVICE = 0x21
	CS_CONFIGURATION = 0x22
	CS_STRING = 0x23
	CS_INTERFACE = 0x24
	CS_ENDPOINT = 0x25

	VC_DESCRIPTOR_UNDEFINED = 0x00
	VC_HEADER = 0x01
	VC_INPUT_TERMINAL = 0x02
	VC_OUTPUT_TERMINAL = 0x03
	VC_SELECTOR_UNIT = 0x04
	VC_PROCESSING_UNIT = 0x05
	VC_EXTENSION_UNIT = 0x06
	VC_ENCODING_UNIT  = 0x07

	VS_UNDEFINED = 0x00
	VS_INPUT_HEADER = 0x01
	VS_OUTPUT_HEADER = 0x02
	VS_STILL_IMAGE_FRAME = 0x03
	VS_FORMAT_UNCOMPRESSED = 0x04
	VS_FRAME_UNCOMPRESSED = 0x05
	VS_FORMAT_MJPEG = 0x06
	VS_FRAME_MJPEG = 0x07
	VS_FORMAT_MJPEG2TS = 0x0a
	VS_FORMAT_DV = 0x0c
	VS_COLORFORMAT = 0x0d
	VS_FORMAT_FRAME_BASED = 0x10
	VS_FRAME_FRAME_BASED = 0x11
	VS_FORMAT_STREAM_BASED = 0x12
	VS_FORMAT_FORMAT_H264 = 0x13
	VS_FRAME_H264 = 0x14
	VS_FORMAT_H264_SIMULCAST = 0x15
	VS_FORMAT_VP8 = 0x16
	VS_FRAME_VP8 = 0x17
	VS_FORMAT_VP8_SIMUCAST = 0x18

	EP_UNDEFINED = 0x00
	EP_GENERAL = 0x01
	EP_ENDPOINT = 0x02
	EP_INTERRUPT = 0x03

	RC_UNDEFINED = 0x00
	SET_CUR = 0x01
	SET_CUR_ALL = 0x11
	GET_CUR = 0x81
	GET_MIN = 0x82
	GET_MAX = 0x83
	GET_RES = 0x84
	GET_LEN = 0x85
	GET_INFO = 0x86
	GET_DEF = 0x87
	GET_CUR_ALL = 0x91
	GET_MIN_ALL = 0x92
	GET_MAX_ALL = 0x93
	GET_RES_ALL = 0x94
	GET_DEF_ALL = 0x97

	VC_CONTROL_UNDEFINED = 0x00
	VC_VIDEO_POWER_MODE_CONTROL = 0x01
	VC_REQUEST_ERROR_CODE_CONTROL = 0x02

	TE_CONTROL_UNDEFINED = 0x00

	SU_CONTROL_UNDEFINED = 0x00
	SU_INPUT_SELECT_CONTROL = 0x01

	CT_CONTROL_UNDEFINED = 0x00
	CT_SCANNING_MODE_CONTROL = 0x01
	CT_AE_MODE_CONTROL = 0x02
	CT_AE_PRIORITY_CONTROL = 0x03
	CT_EXPOSURE_TIME_ABSOLUTE_CONTROL = 0x04
	CT_EXPOSURE_TIME_RELATIVE_CONTROL = 0x05
	CT_FOCUS_ABSOLUTE_CONTROL = 0x06
	CT_FOCUS_RELATIVE_CONTROL = 0x07
	CT_FOCUS_AUTO_CONTROL = 0x08
	CT_IRIS_ABSOLUTE_CONTROL = 0x09
	CT_IRIS_RELATIVE_CONTROL = 0x0A
	CT_ZOOM_ABSOLUTE_CONTROL = 0x0B
	CT_ZOOM_RELATIVE_CONTROL = 0x0C
	CT_PANTILT_ABSOLUTE_CONTROL = 0x0D
	CT_PANTILT_RELATIVE_CONTROL = 0x0E
	CT_ROLL_ABSOLUTE_CONTROL = 0x0F
	CT_ROLL_RELATIVE_CONTROL = 0x10
	CT_PRIVACY_CONTROL = 0x11
	CT_FOCUS_SIMPLE_CONTROL = 0x12
	CT_WINDOW_CONTROL = 0x13
	CT_REGION_OF_INTEREST_CONTROL = 0x14

	PU_CONTROL_UNDEFINED = 0x00
	PU_BACKLIGHT_COMPENSATION_CONTROL = 0x01
	PU_BRIGHTNESS_CONTROL = 0x02
	PU_CONTRAST_CONTROL = 0x03
	PU_GAIN_CONTROL = 0x04
	PU_POWER_LINE_FREQUENCY_CONTROL = 0x05
	PU_HUE_CONTROL = 0x06
	PU_SATURATION_CONTROL = 0x07
	PU_SHARPNESS_CONTROL = 0x08
	PU_GAMMA_CONTROL = 0x09
	PU_WHITE_BALANCE_TEMPERATURE_CONTROL = 0x0A
	PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL = 0x0B
	PU_WHITE_BALANCE_COMPONENT_CONTROL = 0x0C
	PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL = 0x0D
	PU_DIGITAL_MULTIPLIER_CONTROL = 0x0E
	PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL = 0x0F
	PU_HUE_AUTO_CONTROL = 0x10
	PU_ANALOG_VIDEO_STANDARD_CONTROL = 0x11
	PU_ANALOG_LOCK_STATUS_CONTROL = 0x12
	PU_CONTRAST_AUTO_CONTROL = 0x13

	EU_CONTROL_UNDEFINED = 0x00
	EU_SELECT_LAYER_CONTROL = 0x01
	EU_PROFILE_TOOLSET_CONTROL = 0x02
	EU_VIDEO_RESOLUTION_CONTROL = 0x03
	EU_MIN_FRAME_INTERVAL_CONTROL = 0x04
	EU_SLICE_MODE_CONTROL = 0x05
	EU_RATE_CONTROL_MODE_CONTROL = 0x06
	EU_AVERAGE_BITRATE_CONTROL = 0x07
	EU_CPB_SIZE_CONTROL = 0x08
	EU_PEAK_BIT_RATE_CONTROL = 0x09
	EU_QUANTIZATION_PARAMS_CONTROL = 0x0A
	EU_SYNC_REF_FRAME_CONTROL = 0x0B
	EU_LTR_BUFFER_CONTROL = 0x0C
	EU_LTR_PICTURE_CONTROL = 0x0D
	EU_LTR_VALIDATION_CONTROL = 0x0E
	EU_LEVEL_IDC_LIMIT_CONTROL = 0x0F
	EU_SEI_PAYLOADTYPE_CONTROL = 0x10
	EU_QP_RANGE_CONTROL = 0x11
	EU_PRIORITY_CONTROL = 0x12
	EU_START_OR_STOP_LAYER_CONTROL = 0x13
	EU_ERROR_RESILIENCY_CONTROL = 0x14

	XU_CONTROL_UNDEFINED = 0x00

	VS_CONTROL_UNDEFINED = 0x00
	VS_PROBE_CONTROL = 0x01
	VS_COMMIT_CONTROL = 0x02
	VS_STILL_PROBE_CONTROL = 0x03
	VS_STILL_COMMIT_CONTROL = 0x04
	VS_STILL_IMAGE_TRIGGER_CONTROL = 0x05
	VS_STREAM_ERROR_CODE_CONTROL = 0x06
	VS_GENERATE_KEY_FRAME_CONTROL = 0x07
	VS_UPDATE_FRAME_SEGMENT_CONTROL = 0x08
	VS_SYNCH_DELAY_CONTROL = 0x09

	TT_VENDOR_SPECIFIC = 0x0100
	TT_STREAMING = 0x0101

	ITT_VENDOR_SPECIFIX = 0x0200
	ITT_CAMERA = 0x0201
	ITT_MEDIA_TRANSPORT_INPUT = 0x0202

	OTT_VENDOR_SPECIFIC = 0x0300
	OTT_DISPLAY = 0x0301
	OTT_MEDIA_TRANSPORT_OUTPUT = 0x0302

	EXTERNAL_VENDOR_SPECIFIX = 0x0400
	COMPOSITE_CONNECTOR = 0x0401
	SVIDEO_CONNECTOR = 0x0402
	COMPONENT_CONNECTOR = 0x0403

	module Controls
		SU_CONTROL_UNDEFINED = :SU_CONTROL_UNDEFINED
		SU_INPUT_SELECT_CONTROL = :SU_INPUT_SELECT_CONTROL

		CT_CONTROL_UNDEFINED = :CT_CONTROL_UNDEFINED
		CT_SCANNING_MODE_CONTROL = :CT_SCANNING_MODE_CONTROL
		CT_AE_MODE_CONTROL = :CT_AE_MODE_CONTROL
		CT_AE_PRIORITY_CONTROL = :CT_AE_PRIORITY_CONTROL
		CT_EXPOSURE_TIME_ABSOLUTE_CONTROL = :CT_EXPOSURE_TIME_ABSOLUTE_CONTROL
		CT_EXPOSURE_TIME_RELATIVE_CONTROL = :CT_EXPOSURE_TIME_RELATIVE_CONTROL
		CT_FOCUS_ABSOLUTE_CONTROL = :CT_FOCUS_ABSOLUTE_CONTROL
		CT_FOCUS_RELATIVE_CONTROL = :CT_FOCUS_RELATIVE_CONTROL
		CT_FOCUS_AUTO_CONTROL = :CT_FOCUS_AUTO_CONTROL
		CT_IRIS_ABSOLUTE_CONTROL = :CT_IRIS_ABSOLUTE_CONTROL
		CT_IRIS_RELATIVE_CONTROL = :CT_IRIS_RELATIVE_CONTROL
		CT_ZOOM_ABSOLUTE_CONTROL = :CT_ZOOM_ABSOLUTE_CONTROL
		CT_ZOOM_RELATIVE_CONTROL = :CT_ZOOM_RELATIVE_CONTROL
		CT_PANTILT_ABSOLUTE_CONTROL = :CT_PANTILT_ABSOLUTE_CONTROL
		CT_PANTILT_RELATIVE_CONTROL = :CT_PANTILT_RELATIVE_CONTROL
		CT_ROLL_ABSOLUTE_CONTROL = :CT_ROLL_ABSOLUTE_CONTROL
		CT_ROLL_RELATIVE_CONTROL = :CT_ROLL_RELATIVE_CONTROL
		CT_PRIVACY_CONTROL = :CT_PRIVACY_CONTROL
		CT_FOCUS_SIMPLE_CONTROL = :CT_FOCUS_SIMPLE_CONTROL
		CT_WINDOW_CONTROL = :CT_WINDOW_CONTROL
		CT_REGION_OF_INTEREST_CONTROL = :CT_REGION_OF_INTEREST_CONTROL

		PU_CONTROL_UNDEFINED = :PU_CONTROL_UNDEFINED
		PU_BACKLIGHT_COMPENSATION_CONTROL = :PU_BACKLIGHT_COMPENSATION_CONTROL
		PU_BRIGHTNESS_CONTROL = :PU_BRIGHTNESS_CONTROL
		PU_CONTRAST_CONTROL = :PU_CONTRAST_CONTROL
		PU_GAIN_CONTROL = :PU_GAIN_CONTROL
		PU_POWER_LINE_FREQUENCY_CONTROL = :PU_POWER_LINE_FREQUENCY_CONTROL
		PU_HUE_CONTROL = :PU_HUE_CONTROL
		PU_SATURATION_CONTROL = :PU_SATURATION_CONTROL
		PU_SHARPNESS_CONTROL = :PU_SHARPNESS_CONTROL
		PU_GAMMA_CONTROL = :PU_GAMMA_CONTROL
		PU_WHITE_BALANCE_TEMPERATURE_CONTROL = :PU_WHITE_BALANCE_TEMPERATURE_CONTROL
		PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL = :PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL
		PU_WHITE_BALANCE_COMPONENT_CONTROL = :PU_WHITE_BALANCE_COMPONENT_CONTROL
		PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL = :PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL
		PU_DIGITAL_MULTIPLIER_CONTROL = :PU_DIGITAL_MULTIPLIER_CONTROL
		PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL = :PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL
		PU_HUE_AUTO_CONTROL = :PU_HUE_AUTO_CONTROL
		PU_ANALOG_VIDEO_STANDARD_CONTROL = :PU_ANALOG_VIDEO_STANDARD_CONTROL
		PU_ANALOG_LOCK_STATUS_CONTROL = :PU_ANALOG_LOCK_STATUS_CONTROL
		PU_CONTRAST_AUTO_CONTROL = :PU_CONTRAST_AUTO_CONTROL
	end

	class ClassSpecificVCInterfaceDescriptor
		attr_reader :bDescriptorType
		attr_reader :bDescriptorSubType
		attr_reader :rest

		def self.parse_array(extra)
			extra = StringIO.new(extra, 'r')
			descs = []
			until extra.eof?
				len = extra.read(1).ord
				desc = ClassSpecificVCInterfaceDescriptor.parse(extra.read(len-1))
				descs << desc
			end
			descs
		end

		def self.parse(bytes)
			bDescriptorType, bDescriptorSubType, rest = *bytes.unpack("cca*")
			case [bDescriptorType, bDescriptorSubType]
			when [CS_INTERFACE, VC_HEADER]
				VCInterfaceHeaderDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_INPUT_TERMINAL]
				InputTerminalDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_OUTPUT_TERMINAL]
				OutputTerminalDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_SELECTOR_UNIT]
				SelectorUnitDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_PROCESSING_UNIT]
				ProcessingUnitDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_ENCODING_UNIT]
				EncodingUnitDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			when [CS_INTERFACE, VC_EXTENSION_UNIT]
				ExtensionUnitDescriptor.parse(bDescriptorType, bDescriptorSubType, rest)
			else
				self.new(bDescriptorType, bDescriptorSubType, rest)
			end
		end

		def initialize(bDescriptorType, bDescriptorSubType, rest=nil)
			@bDescriptorType = bDescriptorType
			@bDescriptorSubType = bDescriptorSubType
			@rest = nil
		end

		def short_inspect
			"%s" % [
				self.class.name.sub(/Descriptor$/, ''),
			]
		end
	end

	class VCInterfaceHeaderDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bcdUVC
		attr_reader :wTotalLength
		attr_reader :dwClockFrequency
		attr_reader :bInCollection
		attr_reader :baInterfaceNr

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bcdUVC, wTotalLength, dwClockFrequency, bInCollection, *baInterfaceNr = *rest.unpack("H4vVcc*")
			self.new(bDescriptorType, bDescriptorSubType, bcdUVC, wTotalLength, dwClockFrequency, bInCollection, baInterfaceNr)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bcdUVC, wTotalLength, dwClockFrequency, bInCollection, baInterfaceNr)
			super(bDescriptorType, bDescriptorSubType)
			@bcdUVC = bcdUVC
			@wTotalLength = wTotalLength
			@dwClockFrequency = dwClockFrequency
			@bInCollection = bInCollection
			@baInterfaceNr = baInterfaceNr
		end
	end

	class InputTerminalDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bTerminalID
		attr_reader :wTerminalType
		attr_reader :bAssocTerminal
		attr_reader :iTerminal

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bTerminalID, wTerminalType, bAssocTerminal, iTerminal, rest = *rest.unpack("cvcca*")
			case wTerminalType
			when ITT_CAMERA
				CameraTerminalDescriptor.parse(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, rest)
			else
				self.new(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, rest)
			end
		end

		def initialize(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, rest=nil)
			super(bDescriptorType, bDescriptorSubType)
			@bTerminalID = bTerminalID
			@wTerminalType = wTerminalType
			@bAssocTerminal = bAssocTerminal
			@iTerminal = iTerminal
			@rest = rest
		end

		def bUnitID
			@bTerminalID
		end

		def short_inspect
			"%s bUnitID=%d" % [
				self.class.name.sub(/Descriptor$/, ''),
				self.bUnitID
			]
		end
	end

	class OutputTerminalDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bTerminalID
		attr_reader :wTerminalType
		attr_reader :bAssocTerminal
		attr_reader :bSourceID
		attr_reader :iTerminal

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bTerminalID, wTerminalType, bAssocTerminal, bSourceID, iTerminal, rest = *rest.unpack("cvccca*")
			self.new(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, bSourceID, iTerminal, rest)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, bSourceID, iTerminal, rest=nil)
			super(bDescriptorType, bDescriptorSubType)
			@bTerminalID = bTerminalID
			@wTerminalType = wTerminalType
			@bAssocTerminal = bAssocTerminal
			@bSourceID = bSourceID
			@iTerminal = iTerminal
			@rest = rest
		end

		def bUnitID
			@bTerminalID
		end

		def short_inspect
			"%s bUnitID=%d %s" % [
				self.class.name.sub(/Descriptor$/, ''),
				self.bUnitID,
				self.wTerminalType == TT_STREAMING ? "streaming" : "vendor"
			]
		end
	end

	class CameraTerminalDescriptor < InputTerminalDescriptor
		attr_reader :wObjectiveFocalLengthMin
		attr_reader :wObjectiveFocalLengthMax
		attr_reader :wOcularFocalLength
		attr_reader :bControlSize
		attr_reader :bmControls

		def self.parse(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, rest)
			wObjectiveFocalLengthMin, wObjectiveFocalLengthMax, wOcularFocalLength, bControlSize, bmControls = *rest.unpack("vvvcB24")
			self.new(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, wObjectiveFocalLengthMin, wObjectiveFocalLengthMax, wOcularFocalLength, bControlSize, bmControls)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal, wObjectiveFocalLengthMin, wObjectiveFocalLengthMax, wOcularFocalLength, bControlSize, bmControls)
			super(bDescriptorType, bDescriptorSubType, bTerminalID, wTerminalType, bAssocTerminal, iTerminal)
			@wObjectiveFocalLengthMin = wObjectiveFocalLengthMin
			@wObjectiveFocalLengthMax = wObjectiveFocalLengthMax
			@wOcularFocalLength = wOcularFocalLength
			@bControlSize = bControlSize
			@bmControls = Controls.new(bmControls)
		end

		class Controls
			#		D0: Scanning Mode
			#		D1: Auto-Exposure Mode
			#		D2: Auto-Exposure Priority
			#		D3: Exposure Time (Absolute)
			#		D4: Exposure Time (Relative)
			#		D5: Focus (Absolute)
			#		D6 : Focus (Relative)
			#		D7: Iris (Absolute)
			#		D8 : Iris (Relative)
			#		D9: Zoom (Absolute)
			#		D10: Zoom (Relative)
			#		D11: PanTilt (Absolute)
			#		D12: PanTilt (Relative)
			#		D13: Roll (Absolute)
			#		D14: Roll (Relative)
			#		D15: Reserved
			#		D16: Reserved
			#		D17: Focus, Auto
			#		D18: Privacy
			#		D19: Focus, Simple
			#		D20: Window
			#		D21: Region of Interest
			#		D22 – D23: Reserved, set to zero
			BITS = [
				:Scanning_Mode,
				:Auto_Exposure_Mode,
				:Auto_Exposure_Priority,
				:Exposure_Time_Absolute,
				:Exposure_Time_Relative,
				:Focus_Absolute,
				:Focus_Relative,
				:Iris_Absolute,
				:Iris_Relative,
				:Zoom_Absolute,
				:Zoom_Relative,
				:PanTilt_Absolute,
				:PanTilt_Relative,
				:Roll_Absolute,
				:Roll_Relative,
				:Reserved,
				:Reserved,
				:Focus_Auto,
				:Privacy,
				:Focus_Simple,
				:Window,
				:Region_of_Interest,
			]

			BITS.each do |name|
				attr_reader name
			end

			def initialize(bits)
				bits = bits.reverse
				BITS.each_with_index do |name, index|
					instance_variable_set "@#{name}", bits[index] === "1"
				end
			end
		end

		def short_inspect
			"%s bUnitID=%d\n  %s" % [
				self.class.name.sub(/Descriptor$/, ''),
				self.bUnitID,
				Controls::BITS.select {|n|
					self.bmControls.send(n)
				}.join("  \n")
			]
		end
	end

	class SelectorUnitDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bUnitID
		attr_reader :bNrInPins
		attr_reader :baSourceID
		attr_reader :iSelector

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bUnitID, bNrInPins, *baSourceID = *rest.unpack("ccc*")
			iSelector = nil
			if baSourceID.size >= bNrInPins
				iSelector = baSourceID.pop
			end
			self.new(bDescriptorType, bDescriptorSubType, bUnitID, bNrInPins, baSourceID, iSelector)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bUnitID, bNrInPins, baSourceID, iSelector)
			super(bDescriptorType, bDescriptorSubType)
			@bUnitID = bUnitID
			@bNrInPins = bNrInPins
			@baSourceID = baSourceID
			@iSelector = iSelector
		end
	end

	class ProcessingUnitDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bUnitID
		attr_reader :bSourceID
		attr_reader :wMaxMultiplier
		attr_reader :bControlSize
		attr_reader :bmControls
		attr_reader :iProcessing
		attr_reader :bmVideoStandards

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bUnitID, bSourceID, wMaxMultiplier, bControlSize, rest = *rest.unpack("ccvca*")
			bmControls, iProcessing, bmVideoStandards = *rest.unpack("B#{bControlSize * 8}cB8")
			self.new(bDescriptorType, bDescriptorSubType, bUnitID, bSourceID, wMaxMultiplier, bControlSize, bmControls, iProcessing, bmVideoStandards)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bUnitID, bSourceID, wMaxMultiplier, bControlSize, bmControls, iProcessing, bmVideoStandards)
			super(bDescriptorType, bDescriptorSubType)
			@bUnitID = bUnitID
			@bSourceID = bSourceID
			@wMaxMultiplier = wMaxMultiplier
			@bControlSize = bControlSize
			@bmControls = Controls.new(bmControls)
			@iProcessing = iProcessing
			@bmVideoStandards = bmVideoStandards
		end

		class Controls
			#		D0: Brightness
			#		D1: Contrast
			#		D2: Hue
			#		D3: Saturation
			#		D4: Sharpness
			#		D5: Gamma
			#		D6: White Balance Temperature
			#		D7: White Balance Component
			#		D8: Backlight Compensation
			#		D9: Gain
			#		D10: Power Line Frequency
			#		D11: Hue, Auto
			#		D12: White Balance Temperature, Auto
			#		D13: White Balance Component, Auto
			#		D14: Digital Multiplier
			#		D15: Digital Multiplier Limit
			#		D16: Analog Video Standard
			#		D17: Analog Video Lock Status
			#		D18: Contrast, Auto
			#		D19 – D23: Reserved. Set to zero.
			BITS = [
				:Brightness,
				:Contrast,
				:Hue,
				:Saturation,
				:Sharpness,
				:Gamma,
				:White_Balance_Temperature,
				:White_Balance_Component,
				:Backlight_Compensation,
				:Gain,
				:Power_Line_Frequency,
				:Hue_Auto,
				:White_Balance_Temperature_Auto,
				:White_Balance_Component_Auto,
				:Digital_Multiplier,
				:Digital_Multiplier_Limit,
				:Analog_Video_Standard,
				:Analog_Video_Lock_Status,
				:Contrast_Auto,
			]

			BITS.each do |name|
				attr_reader name
			end

			def initialize(bits)
				bits = bits.reverse
				@bits = bits
				BITS.each_with_index do |name, index|
					instance_variable_set "@#{name}", bits[index] === "1"
				end
			end
		end

		def short_inspect
			"%s bUnitID=%d\n  %s" % [
				self.class.name.sub(/Descriptor$/, ''),
				self.bUnitID,
				Controls::BITS.select {|n|
					self.bmControls.send(n)
				}.join("  \n")
			]
		end
	end

	class EncodingUnitDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bUnitID
		attr_reader :bSourceID
		attr_reader :iEncoding
		attr_reader :bControlSize
		attr_reader :bmControls
		attr_reader :bmControlsRuntime

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bUnitID, bSourceID, iEncoding, bControlSize, bmControls, bmControlsRuntime = *rest.unpack("ccccB24B24")
			self.new(bDescriptorType, bDescriptorSubType, bUnitID, bSourceID, iEncoding, bControlSize, bmControls, bmControlsRuntime)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bUnitID, bSourceID, iEncoding, bControlSize, bmControls, bmControlsRuntime)
			super(bDescriptorType, bDescriptorSubType)
			@bUnitID = bUnitID
			@bSourceID = bSourceID
			@iEncoding = iEncoding
			@bControlSize = bControlSize
			@bmControls = bmControls
			@bmControlsRuntime = bmControlsRuntime
		end
	end

	class ExtensionUnitDescriptor < ClassSpecificVCInterfaceDescriptor
		attr_reader :bUnitID
		attr_reader :guidExtensionCode
		attr_reader :bNumControls
		attr_reader :bNrInPins
		attr_reader :baSourceID
		attr_reader :bControlSize
		attr_reader :bmControls
		attr_reader :iExtension

		def self.parse(bDescriptorType, bDescriptorSubType, rest)
			bUnitID, guidExtensionCode, bNumControls, bNrInPins, rest = *rest.unpack("ca16cca*")
			*baSourceID, rest = *rest.unpack("c#{bNrInPins}a*")
			bControlSize, rest = *rest.unpack("ca*")
			bmControls, iExtension = *rest.unpack("B#{bControlSize*8}c")

			guidExtensionCode = guidExtensionCode.unpack("H8 H4 H4 H4 H12").join("-")

			self.new(bDescriptorType, bDescriptorSubType, bUnitID, guidExtensionCode, bNumControls, bNrInPins, baSourceID, bControlSize, bmControls, iExtension)
		end

		def initialize(bDescriptorType, bDescriptorSubType, bUnitID, guidExtensionCode, bNumControls, bNrInPins, baSourceID, bControlSize, bmControls, iExtension)
			super(bDescriptorType, bDescriptorSubType)
			@bUnitID = bUnitID
			@guidExtensionCode = guidExtensionCode
			@bNumControls = bNumControls
			@bNrInPins = bNrInPins
			@baSourceID = baSourceID
			@bControlSize = bControlSize
			@bmControls = bmControls
			@iExtension = iExtension
		end

		def short_inspect
			"%s bUnitID=%d\n  %s" % [
				self.class.name.sub(/Descriptor$/, ''),
				self.bUnitID,
				self.guidExtensionCode
			]
		end
	end

	class UVCDevice
		def self.libusb
			@@libusb ||= LIBUSB::Context.new
		end

		def self.devices
			libusb.devices(bClass: 0xef, bSubClass: 0x02, bProtocol: 1)
		end

		def self.video_control_interface_settings_of(device)
			video_control_interface_settings = device.interfaces.flat_map {|interface|
				interface.alt_settings.select {|setting|
					setting.bInterfaceClass == CC_VIDEO && setting.bInterfaceSubClass == SC_VIDEOCONTROL
				}
			}
		end

		attr_reader :descriptors

		def initialize(setting)
			@setting = setting
			@descriptors = ClassSpecificVCInterfaceDescriptor.parse_array(setting.extra)
		end

		def camera_terminals
			@descriptors.select {|i| i.kind_of? CameraTerminalDescriptor }
		end

		def processing_units
			@descriptors.select {|i| i.kind_of? ProcessingUnitDescriptor }
		end

		def selector_units
			@descriptors.select {|i| i.kind_of? SelectorUnitDescriptor }
		end

		def extension_units
			@descriptors.select {|i| i.kind_of? ExtensionUnitDescriptor }
		end

		def input_terminals
			@descriptors.select {|u| u.kind_of? InputTerminalDescriptor }
		end

		def output_terminals
			@descriptors.select {|u| u.kind_of? OutputTerminalDescriptor }
		end

		def open
			@handle = @setting.device.open
			if block_given?
				begin
					@handle.claim_interface(@setting.bInterfaceNumber)
					yield @handle
				ensure
					close
				end
			else
				@handle.claim_interface(@setting.bInterfaceNumber)
			end
		end

		def close
			handle = @handle
			@handle = nil
			handle.close
		end

		def set_request(bRequest, control_selector, entityID, data)
			warn "set_request: %#04x %#04x %d %p" % [bRequest, control_selector, entityID, data]
			@handle.control_transfer(
				bmRequestType: 0b00100001, # video control interface
				bRequest: bRequest,
				wValue: (control_selector << 8) | 0x00,
				wIndex: (entityID << 8) | @setting.bInterfaceNumber,
				dataOut: data
			)
		rescue LIBUSB::ERROR_PIPE => e
			raise UVCError.new(error_code)
		end

		def get_request(bRequest, control_selector, entityID, length)
			@handle.control_transfer(
				bmRequestType: 0b10100001, # video control interface
				bRequest: bRequest,
				wValue: (control_selector << 8) | 0x00,
				wIndex: (entityID << 8) | @setting.bInterfaceNumber,
				dataIn: length
			)
		rescue LIBUSB::ERROR_PIPE => e
			raise UVCError.new(error_code)
		end

		def error_code
			bRequestErrorCode = @handle.control_transfer(
				bmRequestType: 0b10100001,
				bRequest: GET_CUR,
				wValue: (VC_REQUEST_ERROR_CODE_CONTROL << 8) | 0x00,
				wIndex: @setting.bInterfaceNumber,
				dataIn: 1
			).unpack("C")[0]
		end

		class UVCError < StandardError
			attr_reader :code
			def initialize(code = nil, msg = nil)
				@code = code
				super(msg || "error with code %#04x: %s" % [code, error_description])
			end

			def error_description
				case @code
				when 0x00
					"No error"
				when 0x01
					"Not ready"
				when 0x02
					"Wrong state"
				when 0x03
					"Power"
				when 0x04
					"Out of range"
				when 0x05
					"Invalid unit"
				when 0x06
					"Invalid control"
				when 0x07
					"Invalid Request"
				when 0x08
					"Invalid value within range"
				else
					"unknown"
				end
			end
		end

		class Info
			attr_reader :supports_get
			attr_reader :supports_set
			attr_reader :disabled_due_to_automatic_mode
			attr_reader :autoupdate_control
			attr_reader :asynchronous_control
			attr_reader :disabled_due_to_incompatibility_with_commit_state

			def initialize(bits)
				bits = bits.reverse.split(//).map {|c| c == "1" }
				@supports_get = bits[0]
				@supports_set = bits[1]
				@disabled_due_to_automatic_mode = bits[2]
				@autoupdate_control = bits[3]
				@asynchronous_control = bits[4]
				@disabled_due_to_incompatibility_with_commit_state = bits[5]
			end
		end

		# mapping
		# size: 1 | unsigned number => C
		# size: 1 | signed number   => c
		# size: 2 | unsigned number => v
		# size: 2 | signed number   => s<
		# size: 4 | unsigned number => V
		# size: 4 | signed number   => l<

		KNOWN_CONTROLS = [
			{
				selector: Controls::CT_SCANNING_MODE_CONTROL,
				length: 1,
				encode: lambda {|x| [x ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1 },
			},
			{
				selector: Controls::CT_AE_MODE_CONTROL,
				length: 1,
				encode: lambda {|mode| [mode].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] },
			},
			{
				selector: Controls::CT_AE_PRIORITY_CONTROL,
				length: 1,
				encode: lambda {|bAutoExposurePriority| [bAutoExposurePriority].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] },
			},
			{
				selector: Controls::CT_EXPOSURE_TIME_ABSOLUTE_CONTROL,
				length: 4,
				encode: lambda {|dwExposureTimeAbsolute| [dwExposureTimeAbsolute].pack("V")},
				decode: lambda {|x| x.unpack("V")[0] },
			},
			{
				selector: Controls::CT_EXPOSURE_TIME_RELATIVE_CONTROL,
				length: 1,
				encode: lambda {|bExposureTimeRelative| [bExposureTimeRelative].pack("c")},
				decode: lambda {|x| x.unpack("c")[0] },
			},
			{
				selector: Controls::CT_FOCUS_ABSOLUTE_CONTROL,
				length: 2,
				encode: lambda {|wFocusAbsolute| [wFocusAbsolute].pack("v")},
				decode: lambda {|x| x.unpack("v")[0] },
			},
			{
				selector: Controls::CT_FOCUS_RELATIVE_CONTROL,
				length: 2,
				encode: lambda {|(bFocusRelative,bSpeed)| [wFocusAbsolute].pack("cC")},
				decode: lambda {|x| x.unpack("cC") },
			},
			{
				selector: Controls::CT_FOCUS_SIMPLE_CONTROL,
				length: 1,
				encode: lambda {|bFocus| [wFocusAbsolute].pack("C")},
				decode: lambda {|x| x.unpack("C") },
			},
			{
				selector: Controls::CT_FOCUS_AUTO_CONTROL,
				length: 1,
				encode: lambda {|bFocusAuto| [bFocusAuto ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1},
			},
			{
				selector: Controls::CT_IRIS_ABSOLUTE_CONTROL,
				length: 2,
				encode: lambda {|wIrisAbsolute| [wIrisAbsolute].pack("v")},
				decode: lambda {|x| x.unpack("v")[0] },
			},
			{
				selector: Controls::CT_IRIS_RELATIVE_CONTROL,
				length: 1,
				encode: lambda {|bIrisRelative| [bIrisRelative].pack("c")},
				decode: lambda {|x| x.unpack("c")[0] },
			},
			{
				selector: Controls::CT_ZOOM_ABSOLUTE_CONTROL,
				length: 2,
				encode: lambda {|wObjectiveFocalLength| [wObjectiveFocalLength].pack("v")},
				decode: lambda {|x| x.unpack("v")[0] },
			},
			{
				selector: Controls::CT_ZOOM_RELATIVE_CONTROL,
				length: 3,
				encode: lambda {|(bZoom, bDigitalZoom, bSpeed)| [bZoom, bDigitalZoom ? 1 : 0, bSpeed].pack("cCC")},
				decode: lambda {|x| x.unpack("cCC").tap {|a| a[1] = a[1] == 1 } },
			},
			{
				selector: Controls::CT_PANTILT_ABSOLUTE_CONTROL,
				length: 8,
				encode: lambda {|(dwPanAbsolute, dwTiltAbsolute)| [dwPanAbsolute, dwTiltAbsolute].pack("l<l<")},
				decode: lambda {|x| x.unpack("l<l<") },
			},
			{
				selector: Controls::CT_PANTILT_RELATIVE_CONTROL,
				length: 4,
				encode: lambda {|(bPanRelative, bPanSpeed, bTiltRelative, bTiltSpeed)| [bPanRelative, bPanSpeed, bTiltRelative, bTiltSpeed].pack("cCcC")},
				decode: lambda {|x| x.unpack("cCcC") },
			},
			{
				selector: Controls::CT_ROLL_ABSOLUTE_CONTROL,
				length: 2,
				encode: lambda {|wRollAbsolute| [wRollAbsolute].pack("s<")},
				decode: lambda {|x| x.unpack("s<")[0] },
			},
			{
				selector: Controls::CT_ROLL_RELATIVE_CONTROL,
				length: 2,
				encode: lambda {|(bRollRelative, bSpeed)| [bRollRelative, bSpeed].pack("cC")},
				decode: lambda {|x| x.unpack("cC") },
			},
			{
				selector: Controls::CT_PRIVACY_CONTROL,
				length: 1,
				encode: lambda {|bPrivacy| [bPrivacy ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1 },
			},
			{
				selector: Controls::CT_WINDOW_CONTROL,
				length: 12,
				encode: lambda {|(wWindow_Top, wWindow_Left, wWindow_Bottom, wWindow_Right, wNumSteps, bmNumStepsUnits)| [wWindow_Top, wWindow_Left, wWindow_Bottom, wWindow_Right, wNumSteps, bmNumStepsUnits].pack("vvvvvv")},
				decode: lambda {|x| x.unpack("vvvvvv") },
			},
			{
				selector: Controls::CT_REGION_OF_INTEREST_CONTROL,
				length: 10,
				encode: lambda {|(wROI_Top, wROI_Left, wROI_Bottom, wROI_Right, bmAutoControls)| [wROI_Top, wROI_Left, wROI_Bottom, wROI_Right, bmAutoControls].pack("vvvvv")},
				decode: lambda {|x| x.unpack("vvvvv") },
			},

			{
				selector: Controls::SU_INPUT_SELECT_CONTROL,
				length: 1,
				encode: lambda {|bSelector| [bSelector].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] },
			},

			{
				selector: Controls::PU_BACKLIGHT_COMPENSATION_CONTROL,
				length: 2,
				encode: lambda {|wBacklightCompensation| [wBacklightCompensation].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_BRIGHTNESS_CONTROL,
				length: 2,
				encode: lambda {|wBrightness| [wBrightness].pack("s<")},
				decode: lambda {|x| x.unpack("s<")[0]},
			},
			{
				selector: Controls::PU_CONTRAST_CONTROL,
				length: 2,
				encode: lambda {|wContrast| [wContrast].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_CONTRAST_AUTO_CONTROL,
				length: 1,
				encode: lambda {|bContrastAuto| [bContrastAuto ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1},
			},
			{
				selector: Controls::PU_GAIN_CONTROL,
				length: 2,
				encode: lambda {|wGain| [wGain].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_POWER_LINE_FREQUENCY_CONTROL,
				length: 1,
				encode: lambda {|bPowerLineFrequency| [bPowerLineFrequency].pack("C")},
				decode: lambda {|x| x.unpack("C")[0]},
			},
			{
				selector: Controls::PU_HUE_CONTROL,
				length: 2,
				encode: lambda {|wHue| [wHue].pack("s<")},
				decode: lambda {|x| x.unpack("s<")[0]},
			},
			{
				selector: Controls::PU_HUE_AUTO_CONTROL,
				length: 1,
				encode: lambda {|bHueAuto| [bHueAuto ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1},
			},
			{
				selector: Controls::PU_SATURATION_CONTROL,
				length: 2,
				encode: lambda {|wSaturation| [wSaturation].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_SHARPNESS_CONTROL,
				length: 2,
				encode: lambda {|wSharpness| [wSharpness].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_GAMMA_CONTROL,
				length: 2,
				encode: lambda {|wGamma| [wGamma].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_WHITE_BALANCE_TEMPERATURE_CONTROL,
				length: 2,
				encode: lambda {|wWhiteBalanceTemperature| [wWhiteBalanceTemperature].pack("v")},
				decode: lambda {|x| x.unpack("v")[0]},
			},
			{
				selector: Controls::PU_WHITE_BALANCE_TEMPERATURE_AUTO_CONTROL,
				length: 1,
				encode: lambda {|bWhiteBalanceTemperatureAuto| [bWhiteBalanceTemperatureAuto ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1},
			},
			{
				selector: Controls::PU_WHITE_BALANCE_COMPONENT_CONTROL,
				length: 4,
				encode: lambda {|(wWhiteBalanceBlue, wWhiteBalanceRed)| [wWhiteBalanceBlue, wWhiteBalanceRed].pack("vv")},
				decode: lambda {|x| x.unpack("vv") },
			},
			{
				selector: Controls::PU_WHITE_BALANCE_COMPONENT_AUTO_CONTROL,
				length: 1,
				encode: lambda {|bWhiteBalanceComponentAuto| [bWhiteBalanceComponentAuto ? 1 : 0].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] == 1},
			},
			{
				selector: Controls::PU_DIGITAL_MULTIPLIER_CONTROL,
				length: 2,
				encode: lambda {|wMultiplierStep| [wMultiplierStep].pack("v")},
				decode: lambda {|x| x.unpack("v")[0] },
			},
			{
				selector: Controls::PU_DIGITAL_MULTIPLIER_LIMIT_CONTROL,
				length: 2,
				encode: lambda {|wMultiplierLimit| [wMultiplierLimit].pack("v")},
				decode: lambda {|x| x.unpack("v")[0] },
			},
			{
				selector: Controls::PU_ANALOG_VIDEO_STANDARD_CONTROL,
				length: 1,
				encode: lambda {|bVideoStandard| [bVideoStandard].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] },
			},
			{
				selector: Controls::PU_ANALOG_LOCK_STATUS_CONTROL,
				length: 1,
				encode: lambda {|bStatus| [bStatus].pack("C")},
				decode: lambda {|x| x.unpack("C")[0] },
			},
		]

		def get_info(control_selector, entityID)
			Info.new(get_request(GET_INFO, control_selector, entityID, 1).unpack("B8")[0])
		end

		def get_len(control_selector, entityID)
			get_request(GET_LEN, control_selector, entityID, 1).unpack("C")[0]
		end

		[:GET_CUR, :GET_DEF, :GET_MIN, :GET_MAX, :GET_RES].each do |name|
			bRequest = UVC.const_get(name)
			define_method(name.to_s.downcase) do |control_selector, entityID, length = nil|
				control = KNOWN_CONTROLS.find {|c| c[:selector] == control_selector }

				length = control[:length] unless length
				data = get_request(bRequest, UVC.const_get(control_selector), entityID, length)
				data = control[:decode].call(data) if data && control
				data
			end
		end

		def set_cur(control_selector, entityID, data)
			control = KNOWN_CONTROLS.find {|c| c[:selector] == control_selector }
			data = control[:encode].call(data) if control
			set_request(SET_CUR, UVC.const_get(control_selector), entityID, data)
		end
	end
end
