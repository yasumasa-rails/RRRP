
  
module YupSchema
extend self

    def create_schema   ### 全画面対象
        yupschema = "let Yup = require('yup')\n"
        yupschema << "export const yupschema = {\n"
        screencode = ""
        ActiveRecord::Base.connection.select_all(strsql(nil)).each do |rec|   
            if screencode != rec["pobject_code_scr"]
                if screencode != ""
                    yupschema <<"           },\n"
                end 
                yupschema << "          #{rec["pobject_code_scr"]}:{\n"
                screencode = rec["pobject_code_scr"]
            end         
            str = "Yup."
            case rec["screenfield_type"] 
            when "timestamp", "timestamp(6)","date"
                str<< %Q%date().min('1900/01/01').max('2100/01/01')%
                #case rec["pobject_code_sfd"] 
                #when /_expiredate/
                #    str<< %Q%.default('2099-12-31')%
                #when /_isudate/
                #    str<< %Q%
                #    .default(function() {
                #        let today = new Date()
                #        return today.getFullYear() + "/" + today.getMonth() + "/" +  today.getDate()
                #      })%
                #end    
            when "varchar", "textarea","char"
                str<< %Q%string()%
                if rec["screenfield_edoptmaxlength"].to_i > 0
                    str<< %Q%.max(#{rec["screenfield_edoptmaxlength"].to_i})%
                end   
                if rec["screenfield_indisp"] == '0'
                    str << %Q%.nullable()% 
                end   
            when "select"
                str<< %Q%string()%
            when "numeric"
                str<< %Q%number()%
                if rec["screenfield_minvalue"].to_i >0
                    str<< %Q%.min(#{rec["screenfield_minvalue"]})%
                end       
                if rec["screenfield_maxvalue"].to_i >0
                    str<< %Q%.max(#{rec["screenfield_maxvalue"]})%
                end 
            end  
            if rec["screenfield_indisp"] != '0'
                str << %Q%.required()% 
            end   
            yupschema << "                  #{rec["pobject_code_sfd"]}:" + str + ",\n"
        end 
            yupschema <<  "         }\n"
            yupschema <<  "     }"
        return {:yupschema=>yupschema}           
    end 
    def create_yupfetchcode screencode       
        yupfetchcode ={}
        ActiveRecord::Base.connection.select_all(fetchcodesql(screencode)).each do |rec|   
            if rec["screenfield_paragraph"]  
                yupfetchcode[rec["pobject_code_sfd"]] = rec["screenfield_paragraph"]
            end    
        end 

        return yupfetchcode           
    end  
    def create_yupcheckcode screencode       
        yupcheckcode ={}
        ActiveRecord::Base.connection.select_all(checkcodesql(screencode)).each do |rec|   
            if rec["screenfield_subindisp"]  
                yupcheckcode[rec["pobject_code_sfd"]] = rec["screenfield_subindisp"]
            end    
        end 
        return yupcheckcode           
    end 
    private
    def strsql screencode
         %Q%select pobject_code_sfd,screenfield_type,screenfield_indisp,screenfield_maxvalue,
                    screenfield_minvalue,screenfield_formatter,	pobject_code_scr ,screenfield_edoptmaxlength,
                    max(screenfield_updated_at) screenfield_updated_at,screenfield_paragraph
                    from r_screenfields
                    where (screenfield_editable !=0 and screenfield_type not in('varchar', 'textarea','char')
                    or (screenfield_editable !=0 and screenfield_edoptmaxlength >0)
                    or (screenfield_indisp != 0 or screenfield_maxvalue >0 or screenfield_minvalue >0 ))
                    #{if screencode then " and pobject_code_scr = '#{screencode}' " else "" end }
                    group by pobject_code_sfd,screenfield_type,screenfield_indisp,screenfield_maxvalue,screenfield_edoptmaxlength,
                    screenfield_minvalue,screenfield_formatter,screenfield_paragraph,pobject_code_scr
                    order by 	pobject_code_scr,pobject_code_sfd%
    end    
    def fetchcodesql screencode
         %Q%select pobject_code_sfd,screenfield_paragraph
                    from r_screenfields
                    where trim(screenfield_paragraph) != ''
                    #{if screencode then " and pobject_code_scr = '#{screencode}' " else "" end }%
    end     
    def checkcodesql screencode
         %Q%select pobject_code_sfd,screenfield_subindisp
                    from r_screenfields
                    where trim(screenfield_subindisp) != '' and screenfield_subindisp is not null
                    #{if screencode then " and pobject_code_scr = '#{screencode}' " else "" end }%
    end  
end