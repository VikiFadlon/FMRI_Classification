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

