## Ghi chú lại một số lỗi hay gặp

### Lỗi khi tích hợp LDAP để ssh login vào hệ thống
	
* Nếu bạn sử dụng một user của ldap login vào một server (đã được cấu hình kết nối tới ldap thành công) mà báo lỗi password không đúng thì cần xem lại định dạng password trên ldap và ssh sử dụng là gì, có thể ssh đang dùng clear text, nhưng trên ldap, password của user được mã hóa bởi sha512, nên cần phải đổi định dạng sao cho hai bên giống nhau.



## Một số câu lệnh thường dùng

* Search 
```sh 
ldapsearch -x -D "cn=Manager,dc=meditech,dc=com" -H ldaps://192.168.30.138 -W
ldapsearch -x -D "cn=Manager,dc=meditech,dc=com" -H ldap://192.168.30.138 -b  "ou=Users,dc=meditech,dc=com" -W "(objectclass=inetOrgPerson)"
ldapsearch -x -D "cn=Manager,dc=meditech,dc=com" -b  "ou=Groups,dc=meditech,dc=com" -W "(objectclass=groupOfNames)"

(&(objectclass=dcObject)(dc=checkmk))
(&(objectclass=*)(gidNumber=501))
```

* Tạo password

```sh
slappasswd

[root@openldap ~]# slappasswd
New password: 
Re-enter new password:
{SSHA}uJczcSTLGFRZIaltALT7Mk5YN/5H+Jo6
```


* Đổi password 
```sh
cat <<EOF > chrootpw.ldif
dn: olcDatabase={0}config,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {SSHA}uJczcSTLGFRZIaltALT7Mk5YN
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f chrootpw.ldif
```

* Tạo file cấu hình 

```sh
cat > chdomain.ldif << EOF
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth"
  read by dn.base="cn=Manager,dc=meditech,dc=com" read by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=meditech,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=meditech,dc=com

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}managerpassword

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by
  dn="cn=Manager,dc=meditech,dc=com" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=Manager,dc=meditech,dc=com" write by * read
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f chdomain.ldif 
```

* Tạo file Manager

```sh
cat > basedomain.ldif << EOF
dn: dc=meditech,dc=com
objectClass: top
objectClass: dcObject
objectclass: organization
o: Meditech JSC
dc: Meditech

dn: cn=Manager,dc=meditech,dc=com
objectClass: organizationalRole
cn: Manager
description: Directory Manager

dn: ou=People,dc=meditech,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=meditech,dc=com
objectClass: organizationalUnit
ou: Group
EOF

ldapadd -x -D cn=Manager,dc=srv,dc=world -W -f basedomain.ldif 
Enter LDAP Password: # password của manager
```

* Check cấu hình 

```sh
slapcat
```

* Đổi pass manager 

```sh
cat <<EOF > manager.ldif
dn:  olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=openstack,dc=org
-
replace: olcRootDN
olcRootDN: dc=Manager,dc=openstack,dc=org
-
add: olcRootPW
olcRootPW: {SSHA}lBDIdfwvZkITal0k9tdhiCUolxpf6anu
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// -f manager.ldif
```

* Tạo ou, cn (openstack)

```sh
cat << EOF > openstack_schema.ldif
dn: ou=Groups,dc=meditech,dc=com
objectClass: top
objectClass: organizationalUnit
ou: groups

dn: ou=Users,dc=meditech,dc=com
objectClass: top
objectClass: organizationalUnit
ou: users

dn: ou=UserGroups,dc=meditech,dc=com
objectClass: top
objectClass: organizationalUnit
ou: usergroups

dn: ou=Roles,dc=meditech,dc=com
objectClass: top
objectClass: organizationalUnit
ou: roles

dn: ou=Projects,dc=meditech,dc=com
objectClass: top
objectClass: organizationalUnit
ou: projects
EOF
ldapmodify -Y EXTERNAL -H ldapi:/// -f openstack_schema.ldif


# Tạo user 
cat <<EOF > adduser.ldif
dn: cn=2a22bf794cdc45d2b1408d73b58fffff,ou=Users,dc=meditech,dc=com
objectClass: person
objectClass: inetOrgPerson
userPassword:: dHJhbmcxMjM0Cg==
cn: 2a22bf794cdc45d2b1408d73b58fffff
sn: tranguet
EOF
ldapmodify -Y EXTERNAL -H ldapi:/// -f adduser.ldif
```



## Tham khảo 

[1] https://devconnected.com/how-to-search-ldap-using-ldapsearch-examples/

