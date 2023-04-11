//
//  TermsAndConditionsVC.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 20/04/22.
//

import UIKit
import WebKit

class TermsAndConditionsVC: BaseViewController {

    @IBOutlet weak var header: UILabel!
    //@IBOutlet weak var termsAndConditionsTV: UITextView!
    @IBOutlet var termsAndCondWebKit: UIWebView!
    var fromSideMenu = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //languagelocalization()
        //termsAndConditionsTV.textAlignment = .justified
        
        DispatchQueue.main.async {
            self.stopLoading()
            self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "century-proclub-t&c", ofType: "html")!) as URL) as URLRequest)
        }
    }
//    func languagelocalization(){
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.header.text = "Terms and conditions"
//            self.termsAndConditionsTV.text = """
//1. The points can be redeemed on some CenturyPly products (refer to the points table or ask CPIL representative for details). New products, if added, will be intimated.
//            
//2. Enrolling for this Program by submitting the duly filled and signed enrolment form to the Century Executive is mandatory and will be deemed as acceptance of these terms and conditions. The reward points accumulation shall start only after member registration into CenturyProClub.
//                       
//3. There is no upper limit on the accumulation of the reward points and the accumulation is correlated to the purchase of Century products.
//
//4. Gifts under the Program cannot be exchanged with credit note or in cash. CPIL will not be responsible for respective product warranty/functionality. Warranty/guarantee will be as per the rules of the manufacturing company.
//
//5. All types of cars/two-wheelers/vehicles (in case they are part of the gift items) are ex-showroom basis. Taxes, insurance, documentation charges or difference in showroom prices and other expenses for accessories will have to be borne by the member. The ex-showroom price is subject to a maximum of value equivalent of points. The decision regarding the quantum of reimbursement of ex-showroom price solely rests with CPIL.
//
//6. The company may change, amend, alter, reduce or withdraw the Program at any time, without giving any reason or prior notice. In the event of withdrawal of the Program by the company, the members will have to mandatorily redeem the accumulated reward points within a period of 1 (one) year from the date of withdrawal of the Program and opt for a gift from the eligible gift options.
//
//7. The company will not be liable for any loss or damage, whether direct or indirect, caused to members due to withdrawal or change in the Program.
//
//8. CPIL would do best to deliver the same item as shown in the catalogue. However, in extreme cases, when the product is not available or the model has been withdrawn, the Company reserves the right to substitute the same with some other gift of equivalent value, at its sole discretion.
//
//9. Gifts to be given may not be as per the exact pictures or models shown, but will be replaced by those in similar points range, available during the time of redemption.
//
//10. Images of gifts shown in the Program document are only for representation purposes and the actual colour/brand/model of the same may vary in case of non-availability. The company’s decision in this regard shall be final and binding on the members and no dispute will be entertained in this regard.
//
//11. The gift(s) will be delivered within 30 working days from the date of approval. However, the company will not be responsible for delay in delivery of gift due to non-availability of stock or for any other reason beyond its control.
//
//12. CPIL reserves the right to change points mentioned against each item at any point of time of the scheme. For example, CPIL may decide to increase the points for any item if price for the item increases. However CPIL will not decrease the points in case the price for the item decreases.
//
//13. In case of any conflict or illegitimate claims, the company’s decision will be final and binding. All disputes related to the same will be resolved through arbitration as per the jurisdiction of Kolkata courts.
//
// 14. Scan of material in the dealer location to be invalid.
//
//15. Special priced product to be ineligible for Proclub banking.
//
//I agree to receive SMSs, emails, phone calls or Whatsapp messages, related to the  program, or related to Century Plyboards (India) Ltd., from time-to-time.
//          
//"""
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.header.text = "नियमएवंशर्तें"
//            self.termsAndConditionsTV.text = """
//1. पॉइंट्स को कुछ सेंचुरीप्लाई उत्पादों पर भुनाया जा सकता है (पॉइंट टेबल देखें या विवरण के लिए सीपीआईएल प्रतिनिधि से पूछें)। नए उत्पाद, यदि जोड़े जाते हैं, तो सूचित किया जाएगा।
//2. सेंचुरी एक्जीक्यूटिव को विधिवत भरा और हस्ताक्षरित नामांकन फॉर्म जमा करके इस कार्यक्रम के लिए नामांकन अनिवार्य है और इन नियमों और शर्तों की स्वीकृति के रूप में समझा जाएगा। सेंचुरीप्रोक्लब में सदस्य के पंजीकरण के बाद ही रिवॉर्ड पॉइंट का संचय शुरू होगा।
//3. रिवॉर्ड पॉइंट के संचय की कोई ऊपरी सीमा नहीं है और संचय सेंचुरी उत्पादों की खरीद से संबंधित है।
//4. कार्यक्रम के तहत उपहारों का आदान-प्रदान क्रेडिट नोट या नकद में नहीं किया जा सकता है। सीपीआईएल संबंधित उत्पाद वारंटी/कार्यक्षमता के लिए जिम्मेदार नहीं होगा। वारंटी/गारंटी निर्माण कंपनी के नियमों के अनुसार होगी।
//5. सभी प्रकार की कार/दोपहिया/वाहन (यदि वे उपहार की वस्तुओं का हिस्सा हैं) एक्स-शोरूम आधार पर हैं। कर, बीमा, दस्तावेज शुल्क या शोरूम की कीमतों में अंतर और सामान के लिए अन्य खर्चों को सदस्य को वहन करना होगा। एक्स-शोरूम कीमत अंक के बराबर मूल्य के अधिकतम के अधीन है। एक्स-शोरूम कीमत की प्रतिपूर्ति की मात्रा के संबंध में निर्णय पूरी तरह से सीपीआईएल के पास है।
//6. कंपनी बिना कोई कारण या पूर्व सूचना दिए किसी भी समय कार्यक्रम को बदल सकती है, संशोधित कर सकती है, बदल सकती है, कम कर सकती है या वापस ले सकती है। कंपनी द्वारा कार्यक्रम को वापस लेने की स्थिति में, सदस्यों को कार्यक्रम को वापस लेने की तारीख से 1 (एक) वर्ष की अवधि के भीतर संचित रिवार्ड पॉइंट्स को अनिवार्य रूप से भुनाना होगा और योग्य उपहार विकल्पों में से एक उपहार का विकल्प चुनना होगा। .
//7. कंपनी किसी भी हानि या क्षति के लिए उत्तरदायी नहीं होगी, चाहे वह प्रत्यक्ष या अप्रत्यक्ष हो, जो सदस्यों को कार्यक्रम में वापसी या परिवर्तन के कारण हुई हो।
//8. सीपीआईएल कैटलॉग में दिखाए गए समान आइटम को वितरित करने के लिए सर्वोत्तम प्रयास करेगा। हालांकि, चरम मामलों में, जब उत्पाद उपलब्ध नहीं होता है या मॉडल को वापस ले लिया जाता है, तो कंपनी अपने विवेकाधिकार पर समान मूल्य के किसी अन्य उपहार के साथ इसे बदलने का अधिकार सुरक्षित रखती है।
//9. दिए जाने वाले उपहार दिखाए गए सटीक चित्रों या मॉडलों के अनुसार नहीं हो सकते हैं, लेकिन उन्हें रिडेम्पशन के समय उपलब्ध समान बिंदुओं की श्रेणी में बदल दिया जाएगा।
//10. कार्यक्रम दस्तावेज़ में दिखाए गए उपहारों की छवियां केवल प्रतिनिधित्व उद्देश्यों के लिए हैं और अनुपलब्ध होने की स्थिति में उनका वास्तविक रंग/ब्रांड/मॉडल भिन्न हो सकता है। इस संबंध में कंपनी का निर्णय अंतिम और सदस्यों के लिए बाध्यकारी होगा और इस संबंध में किसी भी विवाद पर विचार नहीं किया जाएगा।
//11. उपहार अनुमोदन की तारीख से 30 कार्य दिवसों के भीतर वितरित किया जाएगा। हालांकि, स्टॉक की अनुपलब्धता या इसके नियंत्रण से परे किसी अन्य कारण से उपहार की डिलीवरी में देरी के लिए कंपनी जिम्मेदार नहीं होगी।
//12. सीपीआईएल योजना के किसी भी समय प्रत्येक मद के सामने उल्लिखित बिंदुओं को बदलने का अधिकार सुरक्षित रखता है। उदाहरण के लिए, सीपीआईएल किसी भी वस्तु के लिए अंक बढ़ाने का निर्णय ले सकता है यदि वस्तु की कीमत बढ़ जाती है। हालांकि सीपीआईएल आइटम की कीमत घटने की स्थिति में अंक कम नहीं करेगा।
//13. किसी भी विरोध या नाजायज दावों के मामले में, कंपनी का निर्णय अंतिम और बाध्यकारी होगा। उसी से संबंधित सभी विवादों को कोलकाता की अदालतों के अधिकार क्षेत्र के अनुसार मध्यस्थता के माध्यम से हल किया जाएगा।
//14. डीलर के स्थान पर सामग्री का स्कैन अमान्य होना।
//15. विशेष कीमत वाला उत्पाद प्रोक्लब बैंकिंग के लिए अपात्र होगा। मैं समय-समय पर कार्यक्रम से संबंधित या सेंचुरी प्लाईबोर्ड्स (इंडिया) लिमिटेड से संबंधित एसएमएस, ईमेल, फोन कॉल या व्हाट्सएप संदेश प्राप्त करने के लिए सहमत हूं।
//            
//"""
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.header.text = "শর্তাবলী"
//            self.termsAndConditionsTV.text = """
//1. পয়েন্টগুলি কিছু সেঞ্চুরিপ্লাই পণ্যগুলিতে রিডিম করা যেতে পারে (পয়েন্ট টেবিল পড়ুন বা বিস্তারিত জানতে CPIL প্রতিনিধিকে জিজ্ঞাসা করুন)। নতুন পণ্য, যোগ করা হলে, অবহিত করা হবে.
//2. সেঞ্চুরি এক্সিকিউটিভের কাছে যথাযথভাবে পূরণ করা এবং স্বাক্ষরিত তালিকাভুক্তি ফর্ম জমা দিয়ে এই প্রোগ্রামের জন্য নথিভুক্ত করা বাধ্যতামূলক এবং এই শর্তাবলীর স্বীকৃতি হিসাবে গণ্য করা হবে৷ সেঞ্চুরিপ্রোক্লাবে সদস্য নিবন্ধনের পরেই পুরস্কার পয়েন্ট সংগ্রহ শুরু হবে।
//3. পুরষ্কার পয়েন্ট সংগ্রহের উপর কোন উচ্চ সীমা নেই এবং জমাটি সেঞ্চুরি পণ্য ক্রয়ের সাথে সম্পর্কিত।
//4. প্রোগ্রামের অধীনে উপহার ক্রেডিট নোট বা নগদে বিনিময় করা যাবে না। CPIL সংশ্লিষ্ট পণ্যের ওয়ারেন্টি/কার্যকারিতার জন্য দায়ী থাকবে না। ওয়্যারেন্টি/গ্যারান্টি হবে ম্যানুফ্যাকচারিং কোম্পানির নিয়ম অনুযায়ী।
//5. সমস্ত ধরণের গাড়ি/টু-হুইলার/যানবাহন (যদি সেগুলি উপহার সামগ্রীর অংশ হয়) এক্স-শোরুম ভিত্তিতে। ট্যাক্স, বীমা, ডকুমেন্টেশন চার্জ বা শোরুমের দামের পার্থক্য এবং আনুষাঙ্গিক অন্যান্য খরচ সদস্যকে বহন করতে হবে। এক্স-শোরুম মূল্য পয়েন্টের সমতুল্য সর্বাধিক মূল্যের সাপেক্ষে। এক্স-শোরুম মূল্য পরিশোধের পরিমাণ সংক্রান্ত সিদ্ধান্ত শুধুমাত্র CPIL-এর উপর নির্ভর করে।
//6. কোম্পানী কোন কারণ বা পূর্ব নোটিশ ছাড়াই যে কোন সময় প্রোগ্রাম পরিবর্তন, সংশোধন, পরিবর্তন, হ্রাস বা প্রত্যাহার করতে পারে। কোম্পানির দ্বারা প্রোগ্রাম প্রত্যাহার করার ক্ষেত্রে, সদস্যদের অবশ্যই প্রোগ্রাম প্রত্যাহারের তারিখ থেকে 1 (এক) বছরের মধ্যে জমাকৃত পুরষ্কার পয়েন্টগুলিকে রিডিম করতে হবে এবং যোগ্য উপহার বিকল্পগুলি থেকে একটি উপহার বেছে নিতে হবে। .
//7. প্রত্যক্ষ বা পরোক্ষ যাই হোক না কেন, প্রোগ্রামে প্রত্যাহার বা পরিবর্তনের কারণে সদস্যদের কোনো ক্ষতি বা ক্ষতির জন্য কোম্পানি দায়ী থাকবে না।
//8. CPIL ক্যাটালগে দেখানো একই আইটেম সরবরাহ করার জন্য সর্বোত্তম চেষ্টা করবে। যাইহোক, চরম ক্ষেত্রে, যখন পণ্যটি পাওয়া যায় না বা মডেলটি প্রত্যাহার করা হয়, তখন কোম্পানি তার নিজস্ব বিবেচনার ভিত্তিতে, সমমূল্যের অন্য কিছু উপহার দিয়ে এটি প্রতিস্থাপন করার অধিকার সংরক্ষণ করে।
//9. প্রদত্ত উপহারগুলি দেখানো সঠিক ছবি বা মডেল অনুযায়ী নাও হতে পারে, তবে রিডেম্পশনের সময় উপলব্ধ অনুরূপ পয়েন্ট রেঞ্জের দ্বারা প্রতিস্থাপিত হবে।
//10. প্রোগ্রাম ডকুমেন্টে দেখানো উপহারের ছবি শুধুমাত্র প্রতিনিধিত্বের উদ্দেশ্যে এবং অনুপলব্ধতার ক্ষেত্রে এর প্রকৃত রঙ/ব্র্যান্ড/মডেল পরিবর্তিত হতে পারে। এই বিষয়ে কোম্পানির সিদ্ধান্ত চূড়ান্ত এবং সদস্যদের জন্য বাধ্যতামূলক হবে এবং এই বিষয়ে কোন বিরোধ গ্রহণ করা হবে না।
//11. উপহার(গুলি) অনুমোদনের তারিখ থেকে 30 কার্যদিবসের মধ্যে বিতরণ করা হবে৷ যাইহোক, স্টক না থাকা বা তার নিয়ন্ত্রণের বাইরে অন্য কোনো কারণে উপহার বিতরণে বিলম্বের জন্য কোম্পানি দায়ী থাকবে না।
//12. CPIL স্কিমের যেকোনো সময়ে প্রতিটি আইটেমের বিপরীতে উল্লিখিত পয়েন্ট পরিবর্তন করার অধিকার সংরক্ষণ করে। উদাহরণস্বরূপ, আইটেমের দাম বাড়লে CPIL যেকোনো আইটেমের জন্য পয়েন্ট বাড়ানোর সিদ্ধান্ত নিতে পারে। তবে আইটেমের দাম কমে গেলে CPIL পয়েন্ট কমবে না।
//13. কোনো দ্বন্দ্ব বা অবৈধ দাবির ক্ষেত্রে, কোম্পানির সিদ্ধান্ত চূড়ান্ত এবং বাধ্যতামূলক হবে। কলকাতা আদালতের এখতিয়ার অনুযায়ী সালিশির মাধ্যমে এর সাথে সম্পর্কিত সমস্ত বিরোধ নিষ্পত্তি করা হবে।
//14. ডিলার অবস্থানে উপাদানের স্ক্যান অবৈধ হতে হবে।
//15. বিশেষ মূল্যের পণ্য Proclub ব্যাঙ্কিংয়ের জন্য অযোগ্য হতে হবে। আমি সময়ে সময়ে এসএমএস, ইমেল, ফোন কল বা হোয়াটসঅ্যাপ বার্তা পেতে সম্মত হচ্ছি, প্রোগ্রামের সাথে সম্পর্কিত, বা সেঞ্চুরি প্লাইবোর্ড (ইন্ডিয়া) লিমিটেডের সাথে সম্পর্কিত।
//            
//"""
//        }else{
//            self.header.text = "నిబంధనలు&షరతులు"
//            self.termsAndConditionsTV.text = """
//1. కొన్ని CenturyPly ఉత్పత్తులపై పాయింట్‌లను రీడీమ్ చేయవచ్చు (పాయింట్‌ల పట్టికను చూడండి లేదా వివరాల కోసం CPIL ప్రతినిధిని అడగండి). కొత్త ఉత్పత్తులు జోడించబడితే, తెలియజేయబడుతుంది.
//2. సెంచరీ ఎగ్జిక్యూటివ్‌కు సక్రమంగా పూరించిన మరియు సంతకం చేసిన ఎన్‌రోల్‌మెంట్ ఫారమ్‌ను సమర్పించడం ద్వారా ఈ ప్రోగ్రామ్ కోసం నమోదు చేసుకోవడం తప్పనిసరి మరియు ఈ నిబంధనలు మరియు షరతులకు అంగీకారంగా పరిగణించబడుతుంది. సెంచరీప్రోక్లబ్‌లో సభ్యుల నమోదు తర్వాత మాత్రమే రివార్డ్ పాయింట్ల సేకరణ ప్రారంభమవుతుంది.
//3. రివార్డ్ పాయింట్‌ల సంచితంపై ఎటువంటి ఎగువ పరిమితి లేదు మరియు సెంచరీ ఉత్పత్తుల కొనుగోలుకు సంచితం పరస్పర సంబంధం కలిగి ఉంటుంది.
//4. ప్రోగ్రామ్ కింద బహుమతులు క్రెడిట్ నోట్‌తో లేదా నగదుతో మార్పిడి చేయబడవు. సంబంధిత ఉత్పత్తి వారంటీ/ఫంక్షనాలిటీకి CPIL బాధ్యత వహించదు. తయారీ కంపెనీ నిబంధనల ప్రకారం వారంటీ/గ్యారంటీ ఉంటుంది.
//5. అన్ని రకాల కార్లు/ద్విచక్ర వాహనాలు/వాహనాలు (గిఫ్ట్ ఐటెమ్‌లలో భాగమైతే) ఎక్స్-షోరూమ్ ప్రాతిపదికన ఉంటాయి. పన్నులు, బీమా, డాక్యుమెంటేషన్ ఛార్జీలు లేదా షోరూమ్ ధరలలో వ్యత్యాసాన్ని మరియు ఉపకరణాలకు సంబంధించిన ఇతర ఖర్చులను సభ్యుడు భరించాలి. ఎక్స్-షోరూమ్ ధర గరిష్టంగా సమానమైన పాయింట్లకు లోబడి ఉంటుంది. ఎక్స్-షోరూమ్ ధర రీయింబర్స్‌మెంట్ పరిమాణానికి సంబంధించిన నిర్ణయం పూర్తిగా CPILపై ఆధారపడి ఉంటుంది.
//6. కంపెనీ ఏ కారణం లేదా ముందస్తు నోటీసు ఇవ్వకుండా ఎప్పుడైనా ప్రోగ్రామ్‌ను మార్చవచ్చు, సవరించవచ్చు, మార్చవచ్చు, తగ్గించవచ్చు లేదా ఉపసంహరించుకోవచ్చు. కంపెనీ ప్రోగ్రామ్‌ను ఉపసంహరించుకున్న సందర్భంలో, ప్రోగ్రామ్‌ని ఉపసంహరించుకున్న తేదీ నుండి 1 (ఒకటి) సంవత్సరంలోపు సభ్యులు తప్పనిసరిగా సేకరించిన రివార్డ్ పాయింట్‌లను రీడీమ్ చేసుకోవాలి మరియు అర్హత ఉన్న బహుమతి ఎంపికల నుండి బహుమతిని ఎంచుకోవాలి. .
//7. ఉపసంహరణ లేదా ప్రోగ్రామ్‌లో మార్పు కారణంగా సభ్యులకు ప్రత్యక్షంగా లేదా పరోక్షంగా ఏదైనా నష్టం లేదా నష్టానికి కంపెనీ బాధ్యత వహించదు.
//8. కేటలాగ్‌లో చూపిన విధంగా అదే అంశాన్ని డెలివరీ చేయడానికి CPIL ఉత్తమంగా చేస్తుంది. అయితే, తీవ్రమైన సందర్భాల్లో, ఉత్పత్తి అందుబాటులో లేనప్పుడు లేదా మోడల్ ఉపసంహరించబడినప్పుడు, కంపెనీ తన స్వంత అభీష్టానుసారం సమానమైన విలువతో కూడిన ఇతర బహుమతితో దానిని భర్తీ చేసే హక్కును కలిగి ఉంటుంది.
//9. ఇవ్వాల్సిన బహుమతులు చూపబడిన ఖచ్చితమైన చిత్రాలు లేదా మోడల్‌ల ప్రకారం ఉండకపోవచ్చు, కానీ విమోచన సమయంలో అందుబాటులో ఉండే సారూప్య పాయింట్ల పరిధిలో ఉన్న వాటితో భర్తీ చేయబడతాయి.
//10. ప్రోగ్రామ్ డాక్యుమెంట్‌లో చూపబడిన బహుమతుల చిత్రాలు కేవలం ప్రాతినిధ్య ప్రయోజనాల కోసం మాత్రమే మరియు అందుబాటులో లేని పక్షంలో వాటి అసలు రంగు/బ్రాండ్/మోడల్ మారవచ్చు. ఈ విషయంలో కంపెనీ నిర్ణయమే అంతిమమైనది మరియు సభ్యులకు కట్టుబడి ఉంటుంది మరియు ఈ విషయంలో ఎలాంటి వివాదాలు తీసుకోబడవు.
//11. గిఫ్ట్(లు) ఆమోదం పొందిన తేదీ నుండి 30 పని దినాలలోపు డెలివరీ చేయబడతాయి. అయితే, స్టాక్ అందుబాటులో లేకపోవడం లేదా దాని నియంత్రణకు మించిన ఇతర కారణాల వల్ల బహుమతి డెలివరీలో జాప్యానికి కంపెనీ బాధ్యత వహించదు.
//12. పథకం యొక్క ఏ సమయంలోనైనా ప్రతి అంశానికి వ్యతిరేకంగా పేర్కొన్న పాయింట్లను మార్చడానికి CPIL హక్కును కలిగి ఉంది. ఉదాహరణకు, వస్తువు ధర పెరిగితే ఏదైనా వస్తువుకు పాయింట్లను పెంచాలని CPIL నిర్ణయించవచ్చు. అయితే వస్తువు ధర తగ్గితే CPIL పాయింట్లను తగ్గించదు.
//13. ఏదైనా వైరుధ్యం లేదా చట్టవిరుద్ధమైన దావాల విషయంలో, కంపెనీ నిర్ణయం అంతిమమైనది మరియు కట్టుబడి ఉంటుంది. దీనికి సంబంధించిన అన్ని వివాదాలు కోల్‌కతా కోర్టుల అధికార పరిధి ప్రకారం మధ్యవర్తిత్వం ద్వారా పరిష్కరించబడతాయి.
//14. డీలర్ లొకేషన్‌లోని మెటీరియల్‌ని స్కాన్ చేయడం చెల్లదు. 15. ప్రోక్లబ్ బ్యాంకింగ్‌కు అనర్హులుగా ఉండే ప్రత్యేక ధర కలిగిన ఉత్పత్తి. ప్రోగ్రామ్‌కు సంబంధించిన లేదా సెంచరీ ప్లైబోర్డ్స్ (ఇండియా) లిమిటెడ్‌కి సంబంధించిన SMSలు, ఇమెయిల్‌లు, ఫోన్ కాల్‌లు లేదా Whatsapp సందేశాలను ఎప్పటికప్పుడు స్వీకరించడానికి నేను అంగీకరిస్తున్నాను.
//            
//"""
//        }
//    }
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    

}
extension UITextView {

    func centerText() {
        self.textAlignment = .justified
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
