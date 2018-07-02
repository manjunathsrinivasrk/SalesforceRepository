public class KeyWordSearcher
{    
    public static void checkSEKeywords(List<Case> newCasesToProcessList)
    {
        Id queueId = [select Id from Group where DeveloperName = 'KeyWordQueue' and Type = 'Queue'].Id;
        list<string> keywordsSet = new list<string>();
        Boolean flag=false;
        For(KeyWords__c kw: KeyWords__c.getAll().values())
        { 
            keywordsSet.add(kw.Name.toLowerCase());
            system.debug('THE FULL SET IS'+keywordsSet); 
        }
        
        for (Case c: newCasesToProcessList)
        {

            If((c.Subject != null ))
            {
                String subjectAllLower1 = c.Subject.toLowerCase();
                String subjectAllLower = subjectAllLower1.stripHtmlTags();
                List<String> stringList = subjectAllLower.split(' ');
                Set<String> subjectStringSet = new Set<String>(stringList);
                system.debug('THE BODY IS '+c.Description);
                for (String p: stringList)
                    {
                        system.debug('THE p string value is stringList'+p);
                    }
                    
                for (String p: subjectStringSet)
                    {
                        system.debug('THE p string value is subjectStringSet'+p);
                    }
                        
                for(String s: keywordsSet)
                {
                    if(subjectStringSet.contains(s))
                    {
                        c.OwnerId = queueId;
                        flag= true;
                        system.debug('THE OWNER ID IS '+c.OwnerId);
                        system.debug('THE FLAG IS '+flag);
                        break;
                    }
                }  
            }
                    
            if((c.Description != null) )
            {            
                String descriptionAllLower1 = c.Description.toLowerCase();
                string descriptionAllLower = descriptionAllLower1.stripHtmlTags();
                
                System.debug('Description: ' + descriptionAllLower);
                System.debug('Keyword Set: ' + keywordsSet);
                
                List<String> stringList = descriptionAllLower.split(' ');
                
                Set<String> descriptionStringSet = new Set<String>(stringList);


                for (String p: descriptionStringSet )
                    {
                        system.debug('THE string value is descriptionStringSet '+p);
                    }
                    
                    
                for (String p: stringList)
                    {
                        system.debug('THE  string value is stringList'+p);
                    }                

                
                for(String s: keywordsSet)
                {
                   if(descriptionStringSet.contains(s))
                    {
                        c.OwnerId = queueId;
                        system.debug('THE 2ND OWNER ID IS '+c.OwnerId);                        
                        break;
                    }
                }
            }
        }
    }
}