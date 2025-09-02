table 50127 Leave_Category_Table
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;Leave_Description; Text[100])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2;Leave_Category_Name; Text[50])
        {
            DataClassification = ToBeClassified;
            
        }
        field(3;Number_of_Days; Integer)
        {
            DataClassification = ToBeClassified;
            
        }
    }
    
    keys
    {
        key(PK; Leave_Category_Name)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}