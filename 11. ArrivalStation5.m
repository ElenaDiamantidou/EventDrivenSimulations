%Arrival 5

function [ Mean_Packet_Delay ] = ArrivalStation5( Lambda, Stations, Q_Size_Bytes_to_Stop, Period )
Sim_Flag = true;
Time = 0;

Event_List = [1,2,3;0,0,0;4,1,2];

Packet_ID = 0;
%initialize arrays
Q = zeros(4,0);
Q_Size = zeros(1, 0);
Q_Sum = zeros(1, 0);
Mean_Packet_Delay_Extension = zeros(1, 0);

Sum_Bytes = 0;

Sum_Delay = 0;
Counter_Delay = 0;
Mean_Packet_Delay = 0;

while Sim_Flag

    Event = Event_List(1,1);
    Time = Event_List(2,1);

    if Event == 1

        [ Event_List, Sum_Bytes, Packet_ID, Q ] = Event1( Time, Event_List, Lambda, Stations, Sum_Bytes, Packet_ID, Q_Size_Bytes_to_Stop, Q );

    elseif Event == 2

        [ Event_List, Q, Sum_Delay, Counter_Delay, Mean_Packet_Delay_Extension ] = Event2(Time, Event_List, Q, Lambda, Sum_Delay, Counter_Delay, Mean_Packet_Delay_Extension );

    elseif Event == 3

        [ Event_List, Q_Size, Q_Sum ] = Event3(Time, Event_List, Q, Q_Size, Period, Q_Sum );

    elseif Event == 4

        [ Event_List, Sim_Flag, Mean_Packet_Delay ] = Event4(Time, Event_List, Q_Size, Sum_Delay, Counter_Delay, Q_Sum, Mean_Packet_Delay_Extension);

    end

    Event_List(:,1)=[];
    Event_List=(sortrows(Event_List',[2,3]))';

end

end

%-----------------------------------------
%---------------  Event1  ----------------
%-----------------------------------------
function [ Event_List, SumBytes, Packet_ID, Q ] = Event1( Time, Event_List, Lambda, Stations, SumBytes, Packet_ID, Q_Size_Bytes_to_Stop, Q )
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

%create Event1
Event_List(1, end + 1) = 1;
Event_List(2, end) = Time + exprnd(1/Lambda);
Event_List(3, end) = 1;

%Queue elements
Q(1, end+1 ) = Packet_ID;
Q(2, end ) = Time;
Q(3, end ) = Random_from_Stations;
Q(4, end ) = Random_to_Stations;
Q(5, end ) = round((rand*(1518-64))+64);

SumBytes = SumBytes + Q(5, end);

if SumBytes >= Q_Size_Bytes_to_Stop
    %create Event4 - end Simulation
    Event_List(1, end + 1) = 4;
    Event_List(2, end) = Time;
    Event_List(3, end) = 1;
end

end

%-----------------------------------------
%---------------  Event2  ----------------
%-----------------------------------------
function [ Event_List, Q, Sum_Delay, Counter_Delay, Mean_Packet_Delay_Extension ] = Event2(Time, Event_List, Q, Lambda, Sum_Delay, Counter_Delay, Mean_Packet_Delay_Extension )
%print id end execution time
sprintf('Event2 at Time %d', Time)

%check if queue is empty else ...
if ~(isempty(Q))
    Sum_Delay = Sum_Delay + Q(2,1);
    Counter_Delay = Counter_Delay + 1;
    Q(:,1) = [];
end

%Arrival5 - extension
Mean_Packet_Delay_Extension(end + 1) = Sum_Delay / Counter_Delay;

%create Event2
Event_List(1, end + 1) = 2;
Event_List(2, end) = Time + exprnd(1/Lambda);
Event_List(3, end) = 1;

end

%-----------------------------------------
%---------------  Event3  ----------------
%-----------------------------------------
function [ Event_List, Q_Size, Q_Sum ] = Event3(Time, Event_List, Q, Q_Size, Period, Q_Sum )
%print id end execution time
sprintf('Event3 at Time %d', Time)

%sum of bytes in Queue
SumBytes = sum(Q(5,:));
Q_Size(end + 1) = SumBytes;

%create Event3
Event_List(1, end + 1) = 3;
Event_List(2, end) = Time + Period;
Event_List(3, end) = 1;

%Arrival 5 - extension
Qlength = length(Q);
Q_Sum(end+1) = Qlength;
end

%-----------------------------------------
%---------------  Event4  ----------------
%-----------------------------------------
function [ Event_List, Sim_Flag, Mean_Packet_Delay ] = Event4(Time, Event_List, Q_Size, Sum_Delay, Counter_Delay, Q_Sum, Mean_Packet_Delay_Extension)
%print id end execution time
sprintf('Event4 at Time %d', Time)

Sim_Flag = false;
sprintf('Simulation End')

Mean_Packet_Delay = Sum_Delay / Counter_Delay;
figure
plot( Q_Size )
title('Q Size')

figure
plot ( Q_Sum)
title('Q Sum')

figure
plot(Mean_Packet_Delay_Extension)
title('Mean Packet Delay Extension')
end
