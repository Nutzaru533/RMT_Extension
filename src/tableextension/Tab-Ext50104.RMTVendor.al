tableextension 50104 "RMT Vendor" extends Vendor
{
  fields
  {
    // Add changes to table fields here
    field(50101;"RMT VAL";Boolean)
    {
      Caption = 'VAL';
      DataClassification = ToBeClassified;
    }
  }
  var myInt: Integer;
}
