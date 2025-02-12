SELECT 
	fm.family_members_id, 
	ffm.fio_family_members_surname, 
	ffm.fio_family_members_name, 
	ffm.fio_family_members_patronymic, 
	fm.date_birth_family_members,
	COALESCE(o.organization_name, 'Безработный') AS organization_name,
	COALESCE(p.post_name, '-') AS post_name,
	COALESCE(jfm.jobs_family_members_salary, 0) AS jobs_family_members_salary,
	COALESCE(SUM(ep.expence_product_quantity * pr.products_price_unit), 0) AS expenses
FROM 
	public.family_members AS fm
INNER JOIN 
	public.fio_family_members AS ffm 
	ON fm.family_members_id = ffm.fio_family_members_id
LEFT JOIN 
	public.jobs_family_members AS jfm 
	ON fm.family_members_id = jfm.jobs_family_members_id
LEFT JOIN 
	public.organization AS o 
	ON jfm.organization_id = o.organization_id
LEFT JOIN 
	public.post AS p 
	ON jfm.post_id = p.post_id
LEFT JOIN 
	public.expence_product AS ep
	ON fm.family_members_id = ep.family_members_id
LEFT JOIN 
	public.products AS pr
	ON ep.products_id = pr.products_id
GROUP BY
	fm.family_members_id,
	ffm.fio_family_members_surname, 
	ffm.fio_family_members_name, 
	ffm.fio_family_members_patronymic, 
	fm.date_birth_family_members,
	o.organization_name,
	p.post_name,
	jfm.jobs_family_members_salary
ORDER BY
	fm.family_members_id;