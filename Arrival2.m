%Arrival 1
%run -> Arrival1(0.5,50,100)
%--------------------------------------------
%create and manage Events with priorities [2]
%export event flow graphs
%--------------------------------------------

function [ ] = Task2( Sim_Time, K )
%Sim_Time -> Simulation Time
%K -> event counter for  termination
Sim_Flag = true;
Time = 0;

%Every event has i priority
%eg. Event 2 -> priority 2

%Events 1,2,3,4,5 begin at 0
%Event 6 stop simulation
Event_List = [1,2,3,4,5,6;0,0,0,0,0,Sim_Time;1,1,1,1,1,1];
Frequency = zeros(6,2);
Event_Counter=zeros(1,6);
%check for K events simulations
value = sum(Event_Counter);


while Sim_Flag

    Event = Event_List(1,1);
    Time = Event_List(2,1);

    if Event == 1
        [ Event_List,Event_Counter,value,Sim_Flag,Frequency ] = Event1( Event_List,Event_Counter,K,Frequency );
    elseif Event == 2
        [ Event_List,Event_Counter,value,Sim_Flag,Frequency ] = Event2( Event_List,Event_Counter,K,Frequency );
    elseif Event == 3
        [ Event_List,Event_Counter,value,Sim_Flag,Frequency ] = Event3( Event_List,Event_Counter,K,Frequency );
    elseif Event == 4
        [ Event_List,Event_Counter,value,Sim_Flag,Frequency ] = Event4( Event_List,Event_Counter,K,Frequency );
    elseif Event == 5
        [ Event_List,Event_Counter,value,Sim_Flag,Frequency ] = Event5( Event_List,Event_Counter,K,Frequency );
    else
        %terminate simulation
        [ Event_List, Sim_Flag ] = Event6( Event_List,Frequency,Event_Counter,value );
    end

    Event_List(:,1)=[];
    Event_List=(sortrows(Event_List',[2,3]))';

end
    plot(Frequency)

    x=1:5:Sim_Time;
    y=length(Event_List);
    plot(y,x)
end



%-------
%Event1
%-------
function [ Event_List, Event_Counter,value,Sim_Flag,Frequency ] = Event1(Event_List, Event_Counter,K,Frequency)
Time = Event_List(2,1);
Sim_Flag = true;
%r=2,3,4
r=round(rand*2+2);
Event_List(1, end+1) = 1;
Event_List(2, end) = Time+r;
Event_List(3,end) = 1;

%Counters
Event_Counter(1) = Event_Counter(1) + 1;
Frequency(1,end+1) = Frequency(1, end) + 1;
value = sum(Event_Counter);

disp('Event1 runs')

%1st termination criterion
if value==K
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End for K=%i\n',K)
end
%2nd termination criterion
temp = false;
%look the last element of array Frequency to check "3 simulation"
if Frequency(1,end) == 3
    temp=true;
end
if temp==true
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End || Event1 performed 3 times in succession')
end
end

%-------
%Event2
%-------
function [ Event_List, Event_Counter,value,Sim_Flag,Frequency ] = Event2(Event_List,Event_Counter,K,Frequency)
Time = Event_List(2,1);
Sim_Flag = true;

%create event3
randValue = rand();
if randValue < 0.2
    Event_List(1, end+1) = 3;
    Event_List(2, end) = Time;
    Event_List(3,end) = 3;
end

%Counters
Event_Counter(2) = Event_Counter(2) + 1;
Frequency(2,end) = Frequency(2, end-1) + 1;
value = sum(Event_Counter);

disp('Event2 runs')

%1st termination criterion
if value==K
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End for K=%i\n',K)
end
%2nd termination criterion
temp = false;
%look the last element of array Frequency to check "3 simulation"
if Frequency(2,end) == 3
    temp=true;
end
if temp==true
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End || Event2 performed 3 times in succession')
end
end

%-------
%Event3
%-------
function [ Event_List, Event_Counter,value,Sim_Flag,Frequency ] = Event3(Event_List,Event_Counter,K,Frequency)
Time = Event_List(2,1);
Sim_Flag = true;

randValue = rand();
if randValue < 0.4
    Event_List(1, end+1) = 1;
    Event_List(2, end) = Time;
    Event_List(3,end) = 1;
else
    Event_List(1, end+1) = 2;
    Event_List(2, end) = Time;
    Event_List(3,end) = 2;
end

%Counters
Event_Counter(3) = Event_Counter(3) + 1;
Frequency(3,end+1) = Frequency(3,end) + 1;
value = sum(Event_Counter);

disp('Event3 runs')

%1st termination criterion
if value==K
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End for K=%i\n',K)
end
%2nd termination criterion
temp = false;
%look the last element of array Frequency to check "3 simulation"
if Frequency(3,end) == 3
    temp=true;
end
if temp==true
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End || Event3 performed 3 times in succession')
end
end

%-------
%Event4
%-------
function [ Event_List, Event_Counter,value,Sim_Flag,Frequency ] = Event4(Event_List,Event_Counter,K,Frequency)
Time = Event_List(2,1);
Sim_Flag = true;

randValue = rand();
if randValue < 0.1
    Event_List(1, end+1) = 4;
    Event_List(2, end) = Time+10;
    Event_List(3,end) = 4;
elseif (randValue > 0.1) && (randValue < 0.3)
    Event_List(1, end+1) = 1;
    Event_List(2, end) = Time+10;
    Event_List(3,end) = 1;
elseif (randValue > 0.3) && (randValue < 0.6)
    Event_List(1, end+1) = 2;
    Event_List(2, end) = Time+10;
    Event_List(3,end) = 2;
elseif (randValue > 0.6) && (randValue < 0.8)
    Event_List(1, end+1) = 3;
    Event_List(2, end) = Time+10;
    Event_List(3,end) = 3;
end

%Counters
Event_Counter(4) = Event_Counter(4) + 1;
Frequency(4,end+1) = Frequency(4,end) + 1;
value = sum(Event_Counter);

disp('Event4 runs')

%1st termination criterion
if value==K
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End for K=%i\n',K)
end
%2nd termination criterion
temp = false;
%look the last element of array Frequency to check "3 simulation"
if Frequency(4,end) == 3
    temp=true;
end
if temp==true
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    disp('Event6 -> Simulation End || Event4 performed 3 times in succession')
end
end

%-------
%Event5
%-------
function [ Event_List, Event_Counter,value,Sim_Flag,Frequency ] = Event5(Event_List,Event_Counter,K,Frequency)
Time = Event_List(2,1);
Sim_Flag = true;

randValue = rand();
if randValue < 0.335
    temp = rand();
    if temp<0.2
        Event_List(1, end+1) = 1;
        Event_List(2, end) = Time+5;
        Event_List(3,end) = 1;
    elseif (temp>0.2) && (temp<0.4)
        Event_List(1, end+1) = 2;
        Event_List(2, end) = Time+5;
        Event_List(3,end) = 2;
    elseif (temp>0.4) && (temp<0.6)
        Event_List(1, end+1) = 3;
        Event_List(2, end) = Time+5;
        Event_List(3,end) = 3;
    elseif (temp>0.6) && (temp<0.8)
        Event_List(1, end+1) = 4;
        Event_List(2, end) = Time+5;
        Event_List(3,end) = 4;
    else
        Event_List(1, end+1) = 5;
        Event_List(2, end) = Time+5;
        Event_List(3,end) = 5;
    end
end

%Counters
Event_Counter(5) = Event_Counter(5) + 1;
Frequency(5,end+1) = Frequency(5,end) + 1;
value = sum(Event_Counter);

disp('Event5 runs')

%1st termination criterion
if value==K
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End for K=%i\n',K)
end
%2nd termination criterion
temp = false;
%look the last element of array Frequency to check "3 simulation"
if Frequency(5,end) == 3
    temp=true;
end
if temp==true
    Event_List(1, end+1) = 6;
    Event_List(2, end) = Time;
    Event_List(3,end) = 6;
    Sim_Flag = false;
    fprintf('Event6 -> Simulation End || Event5 performed 3 times in succession')
end
end

%-------
%Event6
%-------
function [ Event_List, Sim_Flag, Frequency ] = Event6(Event_List, Frequency,Event_Counter,value)
Sim_Flag = false;
disp('Event6 -> Simulation End')
end
