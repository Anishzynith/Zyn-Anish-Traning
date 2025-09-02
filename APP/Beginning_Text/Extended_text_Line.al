pageextension 50107 ExtendExtension extends "Extended Text Lines"
{
    layout
    {

        addafter(text)
        {
            field(Bold; Rec.Bold)
            {
                Caption = 'Bold';
                ApplicationArea = all;
            }
            field(Italic; Rec.Italic)
            {
                Caption = 'Italic';
                ApplicationArea = all;
            }
            field(UnderLine; Rec.UnderLine)
            {
                Caption = 'UnderLine';
                ApplicationArea = all;
            }
        }
    }
}

