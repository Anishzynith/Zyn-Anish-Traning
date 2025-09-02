// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

namespace DefaultPublisher.vendor;


using Microsoft.Purchases.Vendor;

tableextension 50129 VendorListExt extends "Vendor"
{
    fields
    {
        field(50117; Notes; text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}



