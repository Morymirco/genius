// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore";
import { getAuth } from "firebase/auth";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyDoIyoMHz2UKvnUvysLdw-bAqIni3zjF8A",
    authDomain: "geniusclass-dd3af.firebaseapp.com",
    projectId: "geniusclass-dd3af",
    storageBucket: "geniusclass-dd3af.appspot.com",
    messagingSenderId: "333816781312",
    appId: "1:333816781312:web:839e0311edc8bf17ad56e5"
  };

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
const db = getFirestore(app);
const auth = getAuth(app);

export { app, analytics, db, auth };