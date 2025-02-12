SELECT 
    fm.family_members_id, 
    ffm.fio_family_members_surname, 
    ffm.fio_family_members_name, 
    ffm.fio_family_members_patronymic, 
    fm.date_birth_family_members,
    o.organization_name, 
    p.post_name, 
    jfm.jobs_family_members_salary
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
    ON jfm.post_id = p.post_id;
