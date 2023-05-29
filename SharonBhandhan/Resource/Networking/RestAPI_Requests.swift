//
//  RestAPI_Requests.swift
//  Millers_Customer_App
//
//  Created by ArokiaIT on 10/30/20.
//

import UIKit

typealias JSON = [String: Any]

class RestAPI_Requests {
    private let client = WebClient(baseUrl: baseURl)
    
    // MARK : - CUSTOMER LOGIN
    func login_API(parameters: JSON, completion: @escaping (LoginModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: login_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(LoginModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - FORGOT PASSWORD
    func forgotPassword_API(parameters: JSON, completion: @escaping (ForgotPasswordModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: forgotPassword_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(ForgotPasswordModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - MEMBERSHIP ID VERIFICATION
    func membershipIDVerification_API(parameters: JSON, completion: @escaping (MemberVerificationModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: memberVerification_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(MemberVerificationModels?.self, from: data as! Data)
                    print(result1)
                    completion(result1, nil)
                }
            }catch{
                print(error)
                completion(nil, error)
            }
        }
    }
    
    // MARK : - DASHBOARDN API
    func dashboard_API(parameters: JSON, completion: @escaping (DashboardModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboard_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashboardModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - DASHBOARDN BANNER IMAGES
    func dashboardBanner_API(parameters: JSON, completion: @escaping (DashboardImagesModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: dashboardImages_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(DashboardImagesModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // MARK : - MY REDEMPTION LISTING
    func redemptionListing_Post_API(parameters: JSON, completion: @escaping (MyRedemptionModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myRedemptionList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyRedemptionModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // MARK : - MY EARNING LISTING
    func myEarningListApi(parameters: JSON, completion: @escaping (MyEarningModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myEarningList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyEarningModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    // MARK : - MY DREAM GIFT LISTING
     func myDreamGiftList(parameters: JSON, completion: @escaping (MyDreamGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
             return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                 do{
                     if data != nil{
                         let result1 =  try JSONDecoder().decode(MyDreamGiftModels?.self, from: data as! Data)
                         completion(result1, nil)
                     }
                 }catch{
                     completion(nil, error)
                 }
             }
         }
    
    // MARK : - MY SYNCSTATUS LISTING
     func syncStatusListing(parameters: JSON, completion: @escaping (SyncStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
             return client.load(path: syncStatusListing_URMethod, method: .post, params: parameters) { data, error in
                 do{
                     if data != nil{
                         let result1 =  try JSONDecoder().decode(SyncStatusModel?.self, from: data as! Data)
                         completion(result1, nil)
                     }
                 }catch{
                     completion(nil, error)
                 }
             }
         }
    
    // MARK : - E-WARRANTY LISTING
     func E_WarrantyListing(parameters: JSON, completion: @escaping (E_WarrantyListingModel?, Error?) -> ()) -> URLSessionDataTask? {
             return client.load(path: E_WarrantyListing_URLMethod, method: .post, params: parameters) { data, error in
                 do{
                     if data != nil{
                         let result1 =  try JSONDecoder().decode(E_WarrantyListingModel?.self, from: data as! Data)
                         completion(result1, nil)
                     }
                 }catch{
                     completion(nil, error)
                 }
             }
         }

    //REMOVE DREAM GIFT
    
    func removeDreamGifts(parameters: JSON, completion: @escaping (RemoveGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: removeDreamGift_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RemoveGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MY DREAM GIFT DETAILS
    
    func myDreamGiftDetails(parameters: JSON, completion: @escaping (DetailsGiftModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myDreamGiftList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(DetailsGiftModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //REDEMPTION CATEGORY LISTING
    
    func redemptionCateogryListing(parameters: JSON, completion: @escaping (RedemptionCategoryModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: productCategory_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionCategoryModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //REDEMPTION CATALOGUE LISTING
    
    func redemptionCatalogueListing(parameters: JSON, completion: @escaping (RedemptionCatalogueModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: productCatalogue_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionCatalogueModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //ADD TO CART
    
    func addToCartApi(parameters: JSON, completion: @escaping (AddToCartModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: addToCart_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(AddToCartModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //ADD TO PLANNER
    
    func addToPlannerApi(parameters: JSON, completion: @escaping (AddToPlannerModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: addToPlanner_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(AddToPlannerModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                } 
            }
        }
    
    //MY CART LIST
    
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myCartList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyCartModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // INCREASE CART COUNT
    
    
    func increaseCartCount(parameters: JSON, completion: @escaping (IncreaseProductModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(IncreaseProductModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // REMOVE CART COUNT
    
    
    func removeProduct(parameters: JSON, completion: @escaping (RemoveCartModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: updateMyCart_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RemoveCartModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // PLANNER LISTING
    
    func plannerListApi(parameters: JSON, completion: @escaping (PlannerListModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: plannerList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(PlannerListModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //MY PROFILE DETAILS
    
    func myProfile(parameters: JSON, completion: @escaping (MyProfileModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: myProfile_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(MyProfileModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    //MARK: - ImageSavingAPI
    func imageSavingAPI(parameters: JSON, completion: @escaping (ProfileImageUpdateModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: UpdateCustomerProfileMobileApp, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(ProfileImageUpdateModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    
    // STATE LISTING
    
    func stateList(parameters: JSON, completion: @escaping (StateListModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: stateList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(StateListModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // CITY LISTING
    
    func cityList(parameters: JSON, completion: @escaping (CityListModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: cityList_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(CityListModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // Redemption OTP
    
    func redemptionOTP(parameters: JSON, completion: @escaping (RedemptionOTPModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: getOTP_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionOTPModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // USER ISACTIVE
    
    func userIsActive(parameters: JSON, completion: @escaping (UserStatusModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: userStatus_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(UserStatusModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // REDEMPTION SUBMISSION
    
    func redemptionSubmission(parameters: JSON, completion: @escaping (RedemptionSubmission?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: redemptionSubmission_URLMethod, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(RedemptionSubmission?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //SEND SMS
    
    func sendSMSApi(parameters: JSON, completion: @escaping (SendSMSModel?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: sendSMS_URL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SendSMSModel?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    //SEND SUCCESS MESSAGE
    
    func sendSuccessMessage(parameters: JSON, completion: @escaping (SendSuccessModels?, Error?) -> ()) -> URLSessionDataTask? {
            return client.load(path: sendSuccessURL, method: .post, params: parameters) { data, error in
                do{
                    if data != nil{
                        let result1 =  try JSONDecoder().decode(SendSuccessModels?.self, from: data as! Data)
                        completion(result1, nil)
                    }
                }catch{
                    completion(nil, error)
                }
            }
        }
    
    // REMOVE PRODUCT IN PLANNER LIST
    
    func removePlannedProduct(parameters: JSON, completion: @escaping (RemovePlannedProduct?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: removePlannerURL, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(RemovePlannedProduct?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }

    func areaListApi(parameters: JSON, completion: @escaping (AreaListModels?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: areaList_URLMethod, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(AreaListModels?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    //SAVE EWARRANTY DETAILS
     func saveEwarrantyDetails(parameters: JSON, completion: @escaping (SaveEWarrantyDetails?, Error?) -> ()) -> URLSessionDataTask? {
        return client.load(path: saveEwarrentyDetails, method: .post, params: parameters) { data, error in
            do{
                if data != nil{
                    let result1 =  try JSONDecoder().decode(SaveEWarrantyDetails?.self, from: data as! Data)
                    completion(result1, nil)
                }
            }catch{
                completion(nil, error)
            }
        }
    }
    
    // DOWNLOAD EWARRANTY
    
    //DownloadEWarranty
    
    func downloadEwarranty(parameters: JSON, completion: @escaping (DownloadEWarranty?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: downloadWarrentyURLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(DownloadEWarranty?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
   }
    
    //QUERY LISTING
    
    func queryListingApi(parameters: JSON, completion: @escaping (QueryListingModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: queryListing_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(QueryListingModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
   }
    
  //HELP TOPIC LISING
    
    func helpTopicListingApi(parameters: JSON, completion: @escaping (HelpTopicModel?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: helpTopic_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(HelpTopicModel?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
   }
    
    // CHAT DETAILS LISTING
    
    func chatDetailsApi(parameters: JSON, completion: @escaping (ChatDetailsModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: chatDetails_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(ChatDetailsModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
   }
    
    //NEW QUERY SUBMISSION
    
    func newQuerySubmissionApi(parameters: JSON, completion: @escaping (NewQuerySubmission?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: newQuerySubmission_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(NewQuerySubmission?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //NEW CHAT SUBMISSION
    
    func newChatSubmissio(parameters: JSON, completion: @escaping (NewChatSubmission?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: chatSubmission_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(NewChatSubmission?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //OFFERS AND PROMOTIONS LIST
    
    func offersandPromotions(parameters: JSON, completion: @escaping (OffersandPromotionsVM?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: offersandPromotions_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(OffersandPromotionsVM?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //SAVED UPLOAD/ SCANNED CODES
    
    func submitCodesApi(parameters: JSON, completion: @escaping (ScannedandUploadCodesModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: savedCodes_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(ScannedandUploadCodesModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //CODE SYNC LISTS
    
    func codeSyncList(parameters: JSON, completion: @escaping (SyncStatusModel?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: getQRCodeStatus, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(SyncStatusModel?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //MENU LIST :-
    
    func menuListApi(parameters: JSON, completion: @escaping (MenuModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: menuList_URLMethod, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(MenuModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    // NOTIFICATION LISTING
    
    func notificationList(parameters: JSON, completion: @escaping (NotificationModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: historyNotification, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(NotificationModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //Delete Account
    
    func deleteAccountApi(parameters: JSON, completion: @escaping (DeleteAccountModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: deleteAccountMethodName, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(DeleteAccountModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //Pan verify
    
    func panVerifyApi(parameters: JSON, completion: @escaping (PanModels?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: panMethodName, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(PanModels?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //Pan save
    
    func pansaveApi(parameters: JSON, completion: @escaping (SavePanDetails?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: panSaveMethodName, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(SavePanDetails?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //MARK: - Pan get details
    
    func getpaneApi(parameters: JSON, completion: @escaping (GetpanDetails?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: GetPanDetails, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(GetpanDetails?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
    
    //MARK: - E-WARENTY - SCAN CODE VALIDATION
    
    func ewarrentyScanCodeValidation(parameters: JSON, completion: @escaping (EWarrentyScannerModel?, Error?) -> ()) -> URLSessionDataTask? {
       return client.load(path: getScratchCode_MethodName, method: .post, params: parameters) { data, error in
           do{
               if data != nil{
                   let result1 =  try JSONDecoder().decode(EWarrentyScannerModel?.self, from: data as! Data)
                   completion(result1, nil)
               }
           }catch{
               completion(nil, error)
           }
       }
    }
}
