%Task5

%Buffer1_FIFO_No_Limit(1,1,5,50)
%Total Arrivals = 54
%total arrivals near to 50, exp with l

function [ Q ] = Buffer1_FIFO_No_Limit( l, m, Stats_Period, Sim_Time )
Sim_Flag = true;
Time = 0;

Event_List = [1,2,3,4;0,0,0,Sim_Time;1,2,3,4];

Serial_Number = 1;

Q = zeros( 1, 0 );

Current_Buffer_Occupancy = zeros( 1, 0 );

while Sim_Flag

    Event = Event_List(1,1);
    Time = Event_List(2,1);

    if Event == 1

        [ Event_List, Serial_Number, Q ] = Event1( Time, Event_List, Serial_Number, l, Q );

    elseif Event == 2

        [ Event_List, Q ] = Event2( Time, Event_List, m, Q );

    elseif Event == 3

        [ Event_List, Q, Current_Buffer_Occupancy ] = Event3( Time, Event_List, Stats_Period, Q, Current_Buffer_Occupancy );

    elseif Event == 4

        [ Event_List, Sim_Flag ] = Event4(Time, Event_List, Serial_Number, Current_Buffer_Occupancy);

    end

    Event_List(:,1)=[];
    Event_List=(sortrows(Event_List',[2,3]))';

end

end

%-----------------------------------------
%---------------  Event1  ----------------
%-----------------------------------------
function [ Event_List, Serial_Number, Q ] = Event1( Time, Event_List, Serial_Number, l, Q )
%print id end execution time
sprintf('Event1 at Time %d', Time)

%set serial number in Q
Q(1, end+1) = Serial_Number;
Serial_Number = Serial_Number + 1;

%create Event1
Event_List(1, end + 1) = 1;
Event_List(2,end) = Time +  exprnd(l);
end

%-----------------------------------------
%---------------  Event2  ----------------
%-----------------------------------------
function [ Event_List, Q ] = Event2( Time, Event_List, m, Q )
%print id end execution time
sprintf('Event2 at Time %d', Time)

%check isemty(Q)
if ~isempty(Q)
          %delete first element Q
          Q(1) = [];
end

%create Event2
Event_List(1, end+1) = 2;
Event_List(2,end) = Time + exprnd(m);


end

%-----------------------------------------
%---------------  Event3  ----------------
%-----------------------------------------
function [ Event_List, Q, Current_Buffer_Occupancy ] = Event3( Time, Event_List, Stats_Period, Q, Current_Buffer_Occupancy )
%print id end execution time
sprintf('Event3 at Time %d', Time)

Qlength = length(Q);
Current_Buffer_Occupancy(1,end+1) = Qlength;

%create Evnet3
Event_List(1, end+1) = 3;
Event_List(2,end) = Time + Stats_Period;

end

%-----------------------------------------
%---------------  Event4  ----------------
%-----------------------------------------
function [ Event_List, Sim_Flag ] = Event4(Time, Event_List, Serial_Number, Current_Buffer_Occupancy)

sprintf('Event4 at Time %d', Time)
%print id end execution time
Sim_Flag = false;
sprintf('Simulation End')

sprintf('Total Arrivals = %d', Serial_Number)
%for each time -> objects in buffer
bar( Current_Buffer_Occupancy )

end
