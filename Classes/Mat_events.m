% Global (use in Part 1 and Part 2) - Mat_events class 
% Read Mat_events_conditions.mat file containe events labels
% This is parent class for other classes
%
% Variables
% self.Events <- containe all data from file.
% self.Times <- containe only times for events.
% self.Feels <- containe feel names.
% self.Feels_num <- containe number of feels.
%
% Methods
% self.Event_Table() <- extract data as Table.

classdef (HandleCompatible) Mat_events
   properties (SetAccess = private)
       Events
       Times
       Feels
       Feels_num
   end
   methods 
       function self = Mat_events()
           load 'Mat_events_conditions.mat' Mat_events_conditions
           self.Events = Mat_events_conditions;
           self.Times = self.Events(:,1:2);
           self.Feels = ["Importance","Emotional Intensity","Surprise","Emotional Valence","Vividness","Episodic Memory","Theory Of Mind"];
           self.Feels_num = 7;
       end
       function self = set.Events(self,events) 
          new_events = events;
          for i =length(events):-1:1
              if all(events(i,3:end) == 0)
                  new_events(i,:) = [];
              end
          end
          self.Events = new_events;
       end
       function D = Event_Table(self)
          T = array2table(self.Events);
          T.Properties.VariableNames = {'Start','End','Importance','Emotional Intensity','Surprise','Emotional Valence','Vividness','Episodic Memory','Theory Of Mind'};
          D = T;
       end
   end
end

