require '../lib/psd'

file = ARGV[0] || './images/example.psd'
psd = PSD.new(file)
psd.parse!

outfile = './enginedata'
psd.tree.descendant_layers.each do |l|
  next unless l.layer.adjustments[:type]
  File.write(outfile, l.layer.adjustments[:type].engine_data)
  a = l.layer.adjustments[:type].engine_data
  puts a.to_json
  puts "Exported to #{outfile}"
  exit
end