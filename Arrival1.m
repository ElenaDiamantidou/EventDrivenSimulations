%Arrival 1
%run -> Arrival1(0.5,50,100) 
function [ Total_Arrivals, Arrivals_to_Stations ] = Arrival1( Lambda, Stations, Arrivals_to_Stop )
Sim_Flag = true;
Time = 0;

Event_List = [1;0;3];

Total_Arrivals = 0;

Arrivals_to_Stations = zeros(1,Stations);

while Sim_Flag
    
    Event = Event_List(1,1);
    Time = Event_List(2,1);
    
    if Event == 1
        
        [ Event_List ] = Event1( Time, Event_List, Lambda, Stations );
        
    elseif Event == 2
        
        [ Event_List, Total_Arrivals, Arrivals_to_Stations ] = Event2( Time, Event_List, Total_Arrivals, Arrivals_to_Stations, Arrivals_to_Stop );
        
    elseif Event == 3
        
        [ Event_List, Sim_Flag ] = Event3(Time, Event_List, Total_Arrivals, Arrivals_to_Stations);
        
    end
    
    Event_List(:,1)=[];
    Event_List=(sortrows(Event_List',[2,3]))';
    
end

end

%-----------------------------------------
%---------------  Event1  ----------------
%-----------------------------------------
function [ Event_List ] = Event1( Time, Event_List, Lambda, Stations )
%print id end execution time
sprintf('Event1 at Time %d', Time)

%choose random station - uniform distribution
Random_Station = round(rand*(Stations-1) + 1);

%Create Event2 - exponential distribution
Event_List(1,end+1) = 2;
Event_List(2,end) = Time + exprnd(1/Lambda);
Event_List(3, end) = 2;
%station ID in 4th row Event_List
Event_List(4, end) = Random_Station;

    
end

%-----------------------------------------
%---------------  Event2  ----------------
%-----------------------------------------
function [ Event_List, Total_Arrivals, Arrivals_to_Stations ] = Event2( Time, Event_List, Total_Arrivals, Arrivals_to_Stations, Arrivals_to_Stop )
%print id end execution time
sprintf('Event2 at Time %d', Time)

%change Total_Arrivals and Arrivals_to_Stations
Total_Arrivals = Total_Arrivals + 1;
Arrivals_to_Stations(Event_List(4,1)) = Arrivals_to_Stations(Event_List(4,1)) + 1;

%paragei to gegonos 1
Event_List(1,end+1) = 1;
Event_List(2,end) = Time;
Event_List(3, end) = 1; 

%create Event3 if Arrivals_to_Stations are completed
if Total_Arrivals >= Arrivals_to_Stop
    Event_List(1, end + 1) = 3;
    Event_List(2, end) = Time;
    Event_List(3, end) = 1;
end
end

%-----------------------------------------
%---------------  Event3  ----------------
%-----------------------------------------
%terminate simulation
function [ Event_List, Sim_Flag ] = Event3(Time, Event_List, Total_Arrivals, Arrivals_to_Stations)
sprintf('Event3 at Time %d', Time)
Sim_Flag = false;
sprintf('Simulation End')
sprintf('Total Arrivals = %d', Total_Arrivals)
bar(Arrivals_to_Stations)
end
