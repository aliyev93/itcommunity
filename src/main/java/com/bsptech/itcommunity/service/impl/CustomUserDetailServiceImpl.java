package com.bsptech.itcommunity.service.impl;

import com.bsptech.itcommunity.bean.CustomUserDetail;
import com.bsptech.itcommunity.dao.UserDataInter;
import com.bsptech.itcommunity.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class CustomUserDetailServiceImpl implements UserDetailsService {

    @Autowired
    private UserDataInter userDataInter;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        User user = userDataInter.findByEmailAndEnabled(email, true);

        List<GrantedAuthority> roles = user.getGroupId().getAuthGroupRoleList()
                .stream()
                .map(u -> new SimpleGrantedAuthority(u.getRoleId().getName()))
                .collect(Collectors.toList());

        UserDetails userDetails = new CustomUserDetail(
                user,
                user.getEmail(),
                user.getPassword(),
                roles);

        return userDetails;
    }
}
