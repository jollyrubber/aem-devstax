# install other packages via yum
%w(multitail nano screen git).each do |pkg|

    yum_package pkg

end
