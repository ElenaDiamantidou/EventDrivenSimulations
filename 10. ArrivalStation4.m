%Arrival 4

function [ Q ] = ArrivalSystem4 Lambda, Stations, Q_Size_to_Stop, Period )
Sim_Flag = true;
Time = 0;

Event_List = [1,3,4;0,0,0;5,1,2];

Total_Arrivals_Send = 0;

Total_Arrivals_Receive = 0;

Arrivals_to_Stations = zeros(1,Stations);
Arrivals_from_Stations = zeros(1,Stations);

Packet_ID = 0;

Q = zeros(4,0);

Q_Occupancy = zeros(1, 0);

while Sim_Flag

    Event = Event_List(1,1);
    Time = Event_List(2,1);

    if Event == 1

        [ Event_List, Arrivals_from_Stations, Total_Arrivals_Send ] = Event1( Time, Event_List, Lambda, Stations, Arrivals_from_Stations, Total_Arrivals_Send );

    elseif Event == 2

        [ Event_List, Total_Arrivals_Receive, Arrivals_to_Stations, Q, Packet_ID ] = Event2( Time, Event_List, Total_Arrivals_Receive, Arrivals_to_Stations, Packet_ID, Q, Q_Size_to_Stop );

    elseif Event == 3

        [ Event_List, Q ] = Event3(Time, Event_List, Q, Lambda );

    elseif Event == 4

        [ Event_List, Q, Q_Occupancy ] = Event4(Time, Event_List, Q, Q_Occupancy, Period );

    elseif Event == 5

        [ Event_List, Sim_Flag ] = Event5(Time, Event_List, Q_Occupancy);

    end

    Event_List(:,1)=[];
    Event_List=(sortrows(Event_List',[2,3]))';

end

end

%-----------------------------------------
%---------------  Event1  ----------------
%-----------------------------------------
function [ Event_List, Arrivals_from_Stations, Total_Arrivals_Send ] = Event1( Time, Event_List, Lambda, Stations, Arrivals_from_Stations, Total_Arrivals_Send )
%print id end execution time
sprintf('Event1 at Time %d', Time)

%choose random station
Random_to_Stations = round(rand*(Stations-1) + 1);
Random_from_Stations = round(rand*(Stations-1) + 1);
%different station
while Random_to_Stations==Random_from_Stations
    Random_to_Stations = round(rand*(Stations-1) + 1);
    Random_from_Stations = round(rand*(Stations-1) + 1);
end

Total_Arrivals_Send = Total_Arrivals_Send +1;
Arrivals_from_Stations(Random_from_Stations) = Arrivals_from_Stations(Random_from_Stations) + 1;

%create Event1
Event_List(1, end + 1) = 1;
Event_List(2, end) = Time + exprnd(1/Lambda);
Event_List(3, end) = 1;

%create Event2
Event_List(1, end + 1) = 2;
Event_List(2, end) = Time;
Event_List(3, end) = 1;

%station ID-send in 4th row Event_List and ID-receive in 5th
Event_List(4, end) = Random_from_Stations;
Event_List(5, end) = Random_to_Stations;

end

%-----------------------------------------
%---------------  Event2  ----------------
%-----------------------------------------
function [ Event_List, Total_Arrivals_Receive, Arrivals_to_Stations, Q, Packet_ID ] = Event2( Time, Event_List, Total_Arrivals_Receive, Arrivals_to_Stations, Packet_ID, Q, Q_Size_to_Stop )
%print id end execution time
sprintf('Event2 at Time %d', Time)

Total_Arrivals_Receive = Total_Arrivals_Receive + 1;
Arrivals_to_Stations(Event_List(4,1)) = Arrivals_to_Stations(Event_List(4,1)) + 1;

Q(1, end+1 ) = Packet_ID;
Q(2, end ) = Time;
Q(3, end ) = Event_List(5,1);
Q(4, end ) = Event_List(4,1);

Qlength = length(Q);
if Qlength==Q_Size_to_Stop
    %create Event5 - end Simualtion
    Event_List(1, end + 1) = 5;
    Event_List(2, end) = Time;
    Event_List(3, end) = 1;
end

end

 %-----------------------------------------
%---------------  Event3  ----------------
%-----------------------------------------
function [ Event_List, Q ] = Event3(Time, Event_List, Q, Lambda )
%print id end execution time
sprintf('Event3 at Time %d', Time)

%check if queue is empty else remove the first element and push the others
if ~(isempty(Q))
    Q(:,1) = [];
end

%create Event3
Event_List(1, end + 1) = 3;
Event_List(2, end) = Time + exprnd(1/Lambda);
Event_List(3, end) = 1;
end

%-----------------------------------------
%---------------  Event4  ----------------
%-----------------------------------------
function [ Event_List, Q, Q_Occupancy ] = Event4(Time, Event_List, Q, Q_Occupancy, Period )
%print id end execution time
sprintf('Event4 at Time %d', Time)

%increase Q_Occupancy length
Qlength = length(Q);
Q_Occupancy(end+1) = Qlength;

Event_List(1, end + 1) = 4;
Event_List(2, end) = Time + Period;
Event_List(3, end) = 2;

end

%-----------------------------------------
%---------------  Event5  ----------------
%-----------------------------------------
function [ Event_List, Sim_Flag ] = Event5(Time, Event_List, Q_Occupancy)
%print id end execution time
sprintf('Event5 at Time %d', Time)

Sim_Flag = false;
sprintf('Simulation End')

bar( Q_Occupancy )
end
