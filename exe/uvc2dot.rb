#!/usr/bin/env ruby

require "uvc"
require "pp"

setting = UVC::UVCDevice.video_control_interface_settings_of(UVC::UVCDevice.devices.first).first
uvc = UVC::UVCDevice.new(setting)

ct = uvc.camera_terminals.first
pu = uvc.processing_units.first

dot = $stdout

dot.puts <<-HEADER
digraph uvc {
    graph [
        charset = "UTF-8";
        label = "",
        labelloc = "t",
        labeljust = "c",
        bgcolor = "#343434",
        fontcolor = white,
        fontsize = 18,
        style = "filled",
        rankdir = TB,
        margin = 0.2,
        splines = spline,
        ranksep = 1.0,
        nodesep = 0.9
    ];

    node [
        shape = box,
        colorscheme = "rdylgn11"
        style = "solid,filled",
        fontsize = 16,
        fontcolor = 6,
        fontname = "Migu 1M",
        color = 7,
        fillcolor = 11,
        fixedsize = true,
        height = 3,
        width = 4.2,
    ];

    edge [
        style = solid,
        fontsize = 14,
        fontcolor = white,
        fontname = "Migu 1M",
        color = white,
        labelfloat = true,
        labeldistance = 2.5,
        labelangle = 70
    ];
HEADER

header, *units = uvc.descriptors

units.each do |unit|
        # n#{unit.bUnitID} [ label = "#{unit.class.name.sub(/Descriptor$/, '')} (#{unit.bUnitID})" ];
    dot.puts <<-EON
        n#{unit.bUnitID} [ label = "#{unit.short_inspect}" ];
    EON
end

units.each do |unit|
    case
    when unit.respond_to?(:bSourceID)
        dot.puts "n#{unit.bSourceID} -> n#{unit.bUnitID};"
    when unit.respond_to?(:baSourceID)
        unit.baSourceID.each do |source|
            dot.puts "n#{source} -> n#{unit.bUnitID};"
        end
    end
end

dot.puts <<-FOOTER
}
FOOTER

