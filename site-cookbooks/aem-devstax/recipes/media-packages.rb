%w(ffmpeg ffmpeg-devel ImageMagick ImageMagick-devel).each do |pkg|

    yum_package pkg

end
