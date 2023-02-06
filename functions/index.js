import { auth } from "firebase-functions";


import functions from 'firebase-functions';
import { post } from 'request';

const FCM_SERVER_KEY =   'key=AAAAHgXezdQ:APA91bFp5LtxRiYpw_EiJfoiBsVcZ_YL21SGAyKFvTa1IvtcS7Y82iw3dzMjOPfl1Y0gBy0BnGR21v16sfcrnqf4TdosITInYj_7a63Gu7n_tPadLfP_Gn1B9GPO4or1sWEUCpGan3Fk';

const FCM_TOKEN = 'dtm8PIstzEWHvXRBq1vS1o:APA91bENLFVOk0AwQaDLhy1iHklIwGuUyg87baRAykSxcZXnlYZ8IV5QE81EkVcqpUchLoHoalQJeFcl1E5xibChzis0cztf3Bal2Gzfw8y3YLhCn1vUock5r9XhL_HbDcOXbKH2z_DM';



export const onUserCreate = auth.user().onCreate((user) => {
  const options = {
    url: 'https://fcm.googleapis.com/fcm/send',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `key=${FCM_SERVER_KEY}`,
    },
    body: JSON.stringify({
      to: FCM_TOKEN,
      notification: {
        title: 'New User Created',
        body: `A new user with email ${user.email} was created`,
      },
    }),
  };

  post(options, (error, response, body) => {
    console.log(body);
  });
});

