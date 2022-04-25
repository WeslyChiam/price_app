import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class tncPage extends StatelessWidget {
  const tncPage({Key? key}) : super(key: key);

  Widget mainTitle(data) {
    return Text(
      data,
      style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
    );
  }

  Widget subTitle(data) {
    return Text(
      data,
      style: const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
    );
  }

  Widget content(data) {
    return Text(
      data,
      style: const TextStyle(fontSize: 15.0),
    );
  }

  Widget bulletList(boldText, text) {
    return ListTile(
      leading: const Icon(Icons.arrow_right),
      title: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: boldText,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: black)),
          TextSpan(text: text, style: const TextStyle(color: black))
        ], style: const TextStyle(fontSize: 15.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          mainTitle('END USER LICENSE AGREEMENT'),
          subTitle('Last updated April 17, 2022'),
          content(
              'Price App is licensed to You (End-User) by IT Usaha, located and registered at Level 1, 9, Jalan Puteri 2/7, Bandar Puteri, 47100, Puchong, Selangor, Puchong, Selangor 47100, Malaysia ("Licensor"), for use only under the terms of this License Agreement.'),
          content(
              "By downloading the Licensed Application from Google's software distribution platform ('Play Store'), and any update thereto (as permitted by this License Agreement), You indicate that You agree to be bound by all of the terms and conditions of this License Agreement, and that You accept this License Agreement. Play Store is referred to in this License Agreement as 'Services'"),
          content(
              'The parties of this License Agreement acknowledge that the Services are not a Party to this License Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance and support thereof. IT Usaha, not the Services, is solely responsible for the Licensed Application and the content thereof.'),
          content(
              "This License Agreement may not provide for usage rules for the Licensed Application that are in conflict with the latest Google Play Terms of Service ('Usage Rules'). IT Usaha acknowledges that it had the opportunity to review the Usage Rules and this License Agreement is not conflicting with them."),
          content(
              "Price App when purchased or downloaded through the Services, is licensed to You for use only under the terms of this License Agreement. The Licensor reserves all rights not expressly granted to You. Price App is to be used on devices that operate with Google's operating system ('Android')."),
          mainTitle('1. THE APPLICATION'),
          content(
              "Price App ('Licensed Application') is a piece of software created to Check price of product and changing the database by certain authority — and customized for Android mobile devices ('Devices'). It is used to Check and update database allowing for add, edit and remove."),
          mainTitle('2 SCOPE OF LICENSE'),
          bulletList("2.1 ",
              "This license will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate license is provided for such update, in which case the terms of that new license will govern."),
          bulletList("2.2 ",
              "You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with IT Usaha's prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application."),
          bulletList("2.3 ",
              "You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with IT Usaha's prior written consent)."),
          bulletList("2.4 ",
              "Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages."),
          bulletList("2.5 ",
              "Licensor reserves the right to modify the terms and conditions of licensing."),
          bulletList("2.6 ",
              "Nothing in this license should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that You comply with applicable third-party terms and conditions."),
          mainTitle("3 TECHNICAL REQUIREMENTS"),
          bulletList("3.1 ",
              "Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update."),
          bulletList("3.2 ",
              "You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above."),
          bulletList("3.3 ",
              "Licensor reserves the right to modify the technical specifications as it sees appropriate at any time."),
          mainTitle("4 MAINTENANCE AND SUPPORT"),
          bulletList("4.1 ",
              "The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the Play Store Overview for this Licensed Application."),
          bulletList("4.2 ",
              "IT Usaha and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application."),
          mainTitle("5 USER-GENERATED CONTRIBUTIONS"),
          content(
              "The Licensed Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:"),
          bulletList("1.",
              "The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party."),
          bulletList("2.",
              "You are the creator and owner of or have the necessary licenses, rights, consents, releases, and permissions to use and to authorize us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this License Agreement."),
          bulletList("3.",
              "You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Licensed Application and this License Agreement."),
          bulletList("4.",
              "Your Contributions are not false, inaccurate, or misleading."),
          bulletList("5.",
              "Your Contributions are not unsolicited or unauthorized advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation."),
          bulletList("6.",
              "Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libelous, slanderous, or otherwise objectionable (as determined by us)."),
          bulletList("7.",
              "Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone."),
          bulletList("8.",
              "Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people."),
          bulletList("9.",
              "Your Contributions do not violate any applicable law, regulation, or rule."),
          bulletList("10.",
              "Your Contributions do not violate the privacy or publicity rights of any third party."),
          bulletList("11.",
              "Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors."),
          bulletList("12.",
              "Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap."),
          bulletList("13.",
              "Your Contributions do not otherwise violate, or link to material that violates, any provision of this License Agreement, or any applicable law or regulation."),
          content(
              "Any use of the Licensed Application in violation of the foregoing violates this License Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application."),
          mainTitle("6 CONTRIBUTION LICENSE"),
          content(
              "By posting your Contributions to any part of the Licensed Application or making Contributions accessible to the Licensed Application by linking your account from the Licensed Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and license to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and authorize sublicenses of the foregoing. The use and distribution may occur in any media formats and through any media channels."),
          content(
              "This license will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions."),
          content(
              "We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Licensed Application. You are solely responsible for your Contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions."),
          content(
              "We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to recategorize any Contributions to place them in more appropriate locations in the Licensed Application; and (3) to prescreen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions."),
          mainTitle("7 LIABILITY"),
          bulletList("7.1 ",
              "Licensor's responsibility in the case of violation of obligations and tort shall be limited to intent and gross negligence. Only in case of a breach of essential contractual duties (cardinal obligations), Licensor shall also be liable in case of slight negligence. In any case, liability shall be limited to the foreseeable, contractually typical damages. The limitation mentioned above does not apply to injuries to life, limb, or health."),
          bulletList("7.2 ",
              "Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this License Agreement. To avoid data loss, You are required to make use of backup functions of the Licensed Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Licensed Application, You will not have access to the Licensed Application."),
          mainTitle("8 WARRANTY"),
          bulletList("8.1 ",
              "Licensor warrants that the Licensed Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Licensed Application works as described in the user documentation."),
          bulletList("8.2 ",
              "No warranty is provided for the Licensed Application that is not executable on the device, that has been unauthorizedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of IT Usaha's sphere of influence that affect the executability of the Licensed Application."),
          bulletList("8.3 ",
              "You are required to inspect the Licensed Application immediately after installing it and notify IT Usaha about issues discovered without delay by email provided in Product Claims. The defect report will be taken into consideration and further investigated if it has been emailed within a period of ninety (90) days after discovery."),
          bulletList("8.4 ",
              "If we confirm that the Licensed Application is defective, IT Usaha reserves a choice to remedy the situation either by means of solving the defect or substitute delivery."),
          bulletList("8.5 ",
              "In the event of any failure of the Licensed Application to conform to any applicable warranty, You may notify the Services Store Operator, and Your Licensed Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the Services Store Operator will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other losses, claims, damages, liabilities, expenses, and costs attributable to any negligence to adhere to any warranty."),
          bulletList("8.6 ",
              "If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Licensed Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers."),
          mainTitle("9 PRODUCT CLAIMS"),
          content(
              "IT Usaha and the End-User acknowledge that IT Usaha, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User’s possession and/or use of that Licensed Application, including, but not limited to:"),
          bulletList("(i) ", "product liability claims;"),
          bulletList("(ii) ",
              "any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and"),
          bulletList("(iii) ",
              "claims arising under consumer protection, privacy, or similar legislation."),
          mainTitle("10 LEGAL COMPLIANCE"),
          content(
              "You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a 'terrorist supporting' country; and that You are not listed on any US Government list of prohibited or restricted parties."),
          mainTitle("11 CONTACT INFORMATION"),
          subTitle(
              "For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact the admin"),
          mainTitle("12 TERMINATION"),
          content(
              "The license is valid until terminated by IT Usaha or by You. Your rights under this license will terminate automatically and without notice from IT Usaha if You fail to adhere to any term(s) of this license. Upon License termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application."),
          mainTitle("13 THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY"),
          content(
              "IT Usaha represents and warrants that IT Usaha will comply with applicable third-party terms of agreement when using Licensed Application."),
          content(
              "In Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User License Agreement,' Google's subsidiaries shall be third-party beneficiaries of this End User License Agreement and — upon Your acceptance of the terms and conditions of this License Agreement, Google will have the right (and will be deemed to have accepted the right) to enforce this End User License Agreement against You as a third-party beneficiary thereof."),
          mainTitle("14 INTELLECTUAL PROPERTY RIGHTS"),
          content(
              "IT Usaha and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User's possession and use of that Licensed Application infringes on the third party's intellectual property rights, IT Usaha, and not the Services, will be solely responsible for the investigation, defense, settlement, and discharge or any such intellectual property infringement claims."),
          mainTitle("15 APPLICABLE LAW"),
          content(
              "This License Agreement is governed by the laws of Malaysia excluding its conflicts of law rules."),
          mainTitle("16 MISCELLANEOUS"),
          bulletList("16.1 ",
              "If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose."),
          bulletList("16.2 ",
              "Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing."),
          content(
              "These terms of use were created using Termly's Terms and Conditions Generator."),
        ],
      ),
    );
  }
}
