import 'package:flutter/material.dart';
import '../constants.dart';

class faqPage extends StatefulWidget {
  @override
  _faqPageState createState() => _faqPageState();
}

class _faqPageState extends State<faqPage> {
  Widget mainList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
      itemCount: data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: Text(
            'Frequently Asked Questions',
            style: TextStyle(color: Colors.teal),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),
        body: mainList());
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
          style: TextStyle(fontSize: 15),
        ),
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(
        root.title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

final List<Entry> data = <Entry>[
  Entry(
    'Is online registration mandatory for Covid 19 vaccination?',
    <Entry>[
      Entry(
        ' Vaccination Centres provide for a limited number of on-spot'
        ' registration slots every day. Beneficiaries aged 45 years'
        ' and above can schedule appointments online or walk-in to'
        ' vaccination centres. Beneficiaries aged 18 years and above'
        ' can schedule appointments online or walk-in to Government '
        'vaccination centres. However, beneficiaries aged 18-44 years'
        ' should mandatorily register themselves and schedule appointment'
        ' online before going to a Private vaccination centre. ',
        // <Entry>[
        //   Entry('Row 1'),
        //   Entry('Row 2'),
        //   Entry('Row 3'),
        // ],
      ),
    ],
  ),
  Entry(
    'Can I register for vaccination without Aadhaar card? ',
    <Entry>[
      Entry(
          ' Yes, you can register on CoWIN portal using any of the following ID proofs: '),
    ],
  ),
  Entry(
    ' Is there any registration charges to be paid? ',
    <Entry>[
      Entry('No. There is no registration charge.'),
    ],
  ),
  Entry(
    ' Can I check the vaccine being administered at each vaccination centre? ',
    <Entry>[
      Entry(
          ' Yes, while scheduling an appointment for vaccination, the system will show vaccination centre names along with the name of the vaccine that will be administered. '),
    ],
  ),
  // Entry(
  //   ' The appointment can be rescheduled at any time. In case you are not able to go for vaccination on the date of appointment, you can reschedule the appointment by clicking on “Reschedule” tab. ',
  //   <Entry>[
  //     Entry(' The appointment can be rescheduled at any time. In case you are not able to go for vaccination on the date of appointment, you can reschedule the appointment by clicking on “Reschedule” tab.'),
  //   ],
  // ),
  Entry(
    ' Where will I receive confirmation of date and time of vaccination? ',
    <Entry>[
      Entry(
          ' Once an appointment is scheduled, you will receive the details of the vaccination centre, date and time slot chosen for appointment in an SMS sent to your registered mobile number. You can also download the appointment slip and print it or keep it on your smart phone. '),
    ],
  ),
  Entry(
    ' When I click on vaccination centre it shows '
    'No appointments are available in this period'
    '.'
    'What to do? ',
    <Entry>[
      Entry(
          ' In case of no availability of slots for scheduling appointment for vaccination in the searched vaccination centre, you may try scheduling appointment in other nearby centres. The portal gives you the feature of searching vaccination centres using your PIN code and District.'),
    ],
  ),
];
