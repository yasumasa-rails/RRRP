import * as Yup from 'yup'

 export   let schema = Yup.object().shape({
        itm_expiredate:Yup.date().default(function() { return new Date(2099,12,31)}),
        itm_code:Yup.string().required(), 
        unit_code:Yup.string().required()
       })
       