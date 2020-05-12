size = 4;

array = zeros(size,size);

total = 1;

for i = 1:size

    
    for j = 1:size
        
        if i + j > 2
        
            if i > j

                array(i,j) = nchoosek((i+j-2),(i-1));
                
            else

                array(i,j) = nchoosek((i+j-2),(j-1));

            end
            
        else
            
            array(i,j) = 1;
            
        end
            
    end

end

format long
sum(sum(array))+1







