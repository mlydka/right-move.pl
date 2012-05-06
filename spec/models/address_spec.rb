require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Address, 'being created' do

    it 'should create valid address' do
      lambda do
        create_address
      end.should change(Address, :count).by(1)
    end

    it 'should not require firstname' do
      lambda do
        a = create_address(:firstname => nil)
        a.errors.on(:firstname).should be_nil
      end.should change(Address, :count).by(1)
    end

    describe 'should allow legitimate firstnames' do
      ['Michał', 'Marek', 'Krzysztof Andrzej'
      ].each do |firstname_str|
        it "'#{firstname_str}'" do
          lambda do
            a = create_address(:firstname => firstname_str)
            a.errors.on(:firstname).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate firstnames' do
      ['23', 'Imię-', '@#$%#piotr'
      ].each do |firstname_str|
        it "'#{firstname_str}'" do
          lambda do
            a = create_address(:firstname => firstname_str)
            a.errors.on(:firstname).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should not require lastname' do
      lambda do
        a = create_address(:lastname => nil)
        a.errors.on(:lastname).should be_nil
      end.should change(Address, :count).by(1)
    end

    describe 'should allow legitimate lastnames' do
      ['Bachleda-Curuś', 'Nowak', 'Kowalska Źiółko', 'Łóżko'
      ].each do |lastname_str|
        it "'#{lastname_str}'" do
          lambda do
            u = create_address(:lastname => lastname_str)
            u.errors.on(:lastname).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate lastnames' do
      ['23', '-Nazwisko', '@#$%#Kowalski', 'małpka 7'
      ].each do |lastname_str|
        it "'#{lastname_str}'" do
          lambda do
            a = create_address(:lastname => lastname_str)
            a.errors.on(:lastname).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should not require city' do
      lambda do
        a = create_address(:city => nil)
        a.errors.on(:city).should be_nil
      end.should change(Address, :count).by(1)
    end

    describe 'should allow legitimate cities' do
      ['Kraków', 'krakow', 'moje miasto', 'Aąęćźńółfgh', 'Bielsko-Biała'
      ].each do |city_str|
        it "'#{city_str}'" do
          lambda do
            a = create_address(:city => city_str)
            a.errors.on(:city).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate cities' do
      ['23', 'nazwa_nazwa', '@#$%#Olkusz', '-Bielsko'
      ].each do |city_str|
        it "'#{city_str}'" do
          lambda do
            a = create_address(:city => city_str)
            a.errors.on(:city).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should not require district' do
      lambda do
        a = create_address(:district => nil)
        a.errors.on(:district).should be_nil
      end.should change(Address, :count)
    end
    
    describe 'should allow legitimate districts' do
      ['Kraków-Centrum', 'Bronowice Małe', '', 'Aąęćźńółfgh'
      ].each do |district_str|
        it "'#{district_str}'" do
          lambda do
            a = create_address(:district => district_str)
            a.errors.on(:district).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate districts' do
      ['23', 'nazwa_nazwa', '@#$%#Ruczaj', 'Nowa - Huta'
      ].each do |district_str|
        it "'#{district_str}'" do
          lambda do
            a = create_address(:district => district_str)
            a.errors.on(:district).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should require street' do
      lambda do
        a = create_address(:street => nil)
        a.errors.on(:street).should_not be_nil
      end.should_not change(Address, :count)
    end

    describe 'should allow legitimate streets' do
      ['Nowosądecka', '29 Listopada', '3-ego Maja', 'Wojny i pokoju', 'Żółta'
      ].each do |street_str|
        it "'#{street_str}'" do
          lambda do
            a = create_address(:street => street_str)
            a.errors.on(:street).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate streets' do
      ['#3 Maja', 'Kokosowo - $Kawowa', '-29 Listopada', '11 - ego Listopada'
      ].each do |street_str|
        it "'#{street_str}'" do
          lambda do
            a = create_address(:street => street_str)
            a.errors.on(:street).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it "should require apartment" do
      lambda do
        a = create_address(:apartment => nil)
        a.errors.on(:apartment).should_not be_nil
      end.should_not change(Address, :count)
    end

    describe 'should allow legitimate apartments' do
      ['3', '23', '3a', '23a', '3/4', '23a/4'
      ].each do |apartment_str|
        it "'#{apartment_str}'" do
          lambda do
            u = create_address(:apartment => apartment_str)
            u.errors.on(:apartment).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate apartments' do
      ['#3', '#45', '3-4', '32\34', '%34', '4ł'
      ].each do |apartment_str|
        it "'#{apartment_str}'" do
          lambda do
            u = create_address(:apartment => apartment_str)
            u.errors.on(:apartment).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should not require zip' do
      lambda do
        a = create_address(:zip => nil)
        a.errors.on(:zip).should be_nil
      end.should change(Address, :count).by(1)
    end

    describe 'should allow legitimate zips:' do
      ['32-300', '23 321', '12345'
      ].each do |zip_str|
        it "'#{zip_str}'" do
          lambda do
            a = create_address(:zip => zip_str)
            a.errors.on(:zip).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate zips' do
      ['234-432', '323-321', '3 4', 'as-300', '34 - 123', '#12-432', 'asd', '1234567890', '87#213', '12  123', '1', '32 345 -', '34 - 342'
      ].each do |zip_str|
        it "'#{zip_str}'" do
          lambda do
            a = create_address(:zip => zip_str)
            a.errors.on(:zip).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end
 
    it 'should not require email' do
      lambda do
        a = create_address(:email => nil)
        a.errors.on(:email).should be_nil
      end.should change(Address, :count).by(1)
    end

    describe 'should allow legitimate emails' do
      ['foo@bar.com', '_foo@bar.baz', '-foo@bar.baz', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
       'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
       'hello.-_there@funnychar.com', 'routing-str@gmail.com',
       'domain@can.haz.many.sub.doma.in', 'student.name@university.edu'
      ].each do |email_str|
        it "'#{email_str}'" do
          lambda do
            a = create_address(:email => email_str)
            a.errors.on(:email).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

   describe 'should disallow illegitimate emails' do
      ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@toolongtld.abcdefg', '.bar@baz.com',
       'need.domain.and.tld@de', "tab\t", "newline\n", 'r@.wk', 'foo+bar@baz.com', 'uucp%addr@gmail.com',
       'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com',
       'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
      ].each do |email_str|
        it "'#{email_str}'" do
          lambda do
            a = create_address(:email => email_str)
            a.errors.on(:email).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

    it 'should require phone' do
      lambda do
        a = create_address(:phone => nil)
        a.errors.on(:phone).should_not be_nil
      end.should_not change(Address, :count)
    end

    describe 'should allow llegitimate phones' do
      ['643 18 44', '643-18-44', '64 318 44', '64-318-44', '64318-44', '64318 44', '6431844', '64 31844', '32 643 18 44',
       '0 32 643 18 44', '0-32 643 18 44', '326431840', '505 505 505', '505505505', '505-505-505', '0 505 505 505', '48 505 505 505'
      ].each do |phone_str|
        it "'#{phone_str}'" do
          lambda do
            a = create_address(:phone => phone_str)
            a.errors.on(:phone).should be_nil
          end.should change(Address, :count).by(1)
        end
      end
    end

    describe 'should disallow illegitimate phones' do
      ['123', '12-345678-90987654-3212345678909-87654322123-456789098-76543212345678909876543', '+(48) 345 678 gfd', '++(48) 012 643 21 45', '#643-18-40',
       '+(48) +12 643 21 45', '(0 32) 643 18 44', '+45 321 323 453'
      ].each do |phone_str|
        it "'#{phone_str}'" do
          lambda do
            a = create_address(:phone => phone_str)
            a.errors.on(:phone).should_not be_nil
          end.should_not change(Address, :count)
        end
      end
    end

end