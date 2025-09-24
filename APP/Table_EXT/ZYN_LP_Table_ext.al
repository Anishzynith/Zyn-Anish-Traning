tableextension 50147 ZYN_LoyaltyPointsExt extends Customer
{
    fields
    {
        field(50148; LoyaltyPoints; Integer)
        {
            caption = 'Loyalty Points';
            MinValue = 0;
            MaxValue = 100;
        }
    }
}

