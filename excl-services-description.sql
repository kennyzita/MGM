declare @checking_date date, @report_month int = 10, @report_year int = 2017

if @report_month = 12
		set @checking_date=datefromparts(@report_year +1, 1, 1)
	else
		set @checking_date = datefromparts(@report_year, @report_month + 1, 1)



select distinct e_code_pgc as 'Exclusion Code', dept_code as 'Department ID', vendor_id as 'Vendor Number',vendor_full_name as 'Vendor Name',
invoice_no as 'Invoice Number', check_no as 'Check Number', check_amount as 'Total Payment', percentage as ' Casino Percentage', casino_amount
as 'Casino Amount', check_date as 'Payment Date' 

--, case when procurement_phase_goma = 1 then check_amount else null end as 'A&E'
--, case when procurement_phase_goma = 2 then check_amount else null end as 'Construction / Development'
--, case when procurement_phase_goma = 3 then check_amount else null end as 'Pre-opening Operations'
--, case when a.procurement_phase_goma = 4 then check_amount else null end as 'Operations'
--, case when r.[Vendor Name] <> a.vendor_name  then 'Not Found' else r.[services description] end as 'Services Description'
,dbo.get_service_description_pgc(vendor_full_name) as 'Services Description'
from check_register --a  left outer join exclusion_description_pgc r on a.vendor_name = r.[Vendor Name]
--from check_register where e_code_PGC is not null and procurement_phase=4
where e_code_pgc is not null and procurement_phase_goma = 4 and check_date < @checking_date 
--order by e_code_goma, check_date asc, vendor_name, check_no,  check_amount






