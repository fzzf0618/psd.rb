require 'spec_helper'

describe 'Image Exporting' do
  before(:each) do
    class PSD::Image 
      attr_accessor :pixel_data
    end

    @psd = PSD.new('spec/files/pixel.psd')
  end

  describe "the full preview image" do
    it "should successfully parse the image data" do
      @psd.parse!
      expect(@psd).to be_parsed
      expect(@psd.image).to_not be_nil
      expect(@psd.image.width).to eq(1)
      expect(@psd.image.height).to eq(1)
      expect(@psd.image.pixel_data).to eq([0, 100, 200, 255])
    end

    it "should be able to skip to the image" do
      expect(@psd).to_not be_parsed
      expect(@psd.image.width).to eq(1)
      expect(@psd.image.height).to eq(1)
      expect(@psd.image.pixel_data).to eq([0, 100, 200, 255])
    end

    describe "as PNG" do
      it "should produce a valid PNG object" do
        expect(@psd.image.to_png).to be_an_instance_of(ChunkyPNG::Image)

        # Ensure it's cached
        expect(@psd.image.to_png).to be @psd.image.to_png
        expect(@psd.image.to_png.width).to eq(1)
        expect(@psd.image.to_png.height).to eq(1)
        expect(
          ChunkyPNG::Color.to_truecolor_alpha_bytes(@psd.image.to_png[0,0])
        ).to eq([0, 100, 200, 255])
      end
    end
  end
end