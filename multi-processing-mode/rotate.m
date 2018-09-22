function time=rotate(r,from,to)
if r==1%R1
    if to>=from
        time=to-from;
    else%from>to
        time=4-(from-to);
    end
end
if r==2%R2
    if to>=from
        time=to-from;
    else%from>to
        time=7-(from-to);
    end
end
end
    
    
   
