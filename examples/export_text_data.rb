# encoding: UTF-8
require '../lib/psd'
require 'ostruct'
require 'json'
file = ARGV[0] || './images/example.psd'
psd = PSD.new(file)
psd.parse!

outfile = './enginedata'
psd.tree.descendant_layers.each do |l|
  next unless l.layer.adjustments[:type]
  typeHash = l.layer.adjustments[:type].engine_data.to_hash
  puts typeHash.attributes
  # File.open(outfile, "w") do |f|
  #   f.write(JSON.pretty_generate(typeHash))
  # end
  # File.write(outfile, l.layer.adjustments[:type].engine_data)

  exit
end