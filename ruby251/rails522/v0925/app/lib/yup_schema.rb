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
                str<< %Q%date()%
            when "varchar", "textarea","char"
                str<< %Q%string()%
                if rec["screenfield_minvalue"].to_i > 0
                    tr<< %Q%.min(#{rec["screenfield_minvalue"].to_i})%
                end    
                if rec["screenfield_maxvalue"].to_i > 0
                    str<< %Q%.max(#{rec["screenfield_maxvalue"].to_i})%
                end   
            when "select"
                str<< %Q%string()%
            when "number"
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
        ActiveRecord::Base.connection.select_all(strsql(screencode)).each do |rec|   
            if rec["screenfield_paragraph"]  
                yupfetchcode[rec["pobject_code_sfd"]] = rec["screenfield_paragraph"]
            end    
        end 

        return {:yupfetchcode=>yupfetchcode}           
    end 
    private
    def strsql screencode
         %Q%select pobject_code_sfd,screenfield_type,screenfield_indisp,screenfield_maxvalue,
                    screenfield_minvalue,screenfield_formatter,	pobject_code_scr ,
                    max(screenfield_updated_at) screenfield_updated_at,screenfield_paragraph
                    from r_screenfields
                    where (screenfield_editable !=0 and screenfield_type not in('varchar', 'textarea','char')
                    or (screenfield_indisp != 0 or screenfield_maxvalue >0 or screenfield_minvalue >0))
                    #{if screencode then " and pobject_code_scr = '#{screencode}' " else "" end }
                    group by pobject_code_sfd,screenfield_type,screenfield_indisp,screenfield_maxvalue,
                    screenfield_minvalue,screenfield_formatter,screenfield_paragraph,pobject_code_scr
                    order by 	pobject_code_scr,pobject_code_sfd%
    end    
end
