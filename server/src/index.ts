import express from 'express';
const app = express();

interface bodyProps{
    username:String,
    email:String,
    data?:String,
    UserId:Number
}


app.get('/',async(req,res)=>{
    console.log("request comed")
    return res.send("Hello world");
})


app.get("/pro",(req,res)=>{
    try {
        return res.status(200).json({
            msg:"Hello world working "
        })
    } catch (error) {
        
    }
})

app.listen(3000, '0.0.0.0' , () =>{
    console.log("Working properly")
})