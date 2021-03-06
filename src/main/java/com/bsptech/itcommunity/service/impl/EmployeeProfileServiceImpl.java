package com.bsptech.itcommunity.service.impl;

import com.bsptech.itcommunity.dao.*;
import com.bsptech.itcommunity.entity.*;
import com.bsptech.itcommunity.service.inter.EmployeeProfileServiceInter;
import com.bsptech.itcommunity.service.inter.SecurityServiceInter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

//import com.bsptech.itcommunity.security.SecurityUtil;

@Service
@Transactional
public class EmployeeProfileServiceImpl implements EmployeeProfileServiceInter {
    @Autowired
    EmployeeProfileDataInter employeeProfileDataInter;
    @Autowired
    private SecurityServiceInter securityService;


    @Autowired
    private SkillDataInter skillDao;

    @Autowired
    private UserDataInter userDao;
//    @Autowired
//    SecurityUtil securityUtil;

    @Override
    public EmployeeProfile findById(Integer id) {
        Optional<EmployeeProfile> op = employeeProfileDataInter.findById(id);
        return op.isPresent() ? op.get() : null;
    }

    @Override
    public EmployeeProfile findByUserId(User user) {
        return employeeProfileDataInter.findByUserId(user);
    }

    @Override
    public Page<EmployeeProfile> findAll(Pageable pageable) {
        return employeeProfileDataInter.findAll(pageable);
    }

    @Override
    public Page<EmployeeProfile> search(EmployeeProfile e, Pageable pageable) {

        List<Language> languages = new ArrayList<>();
        List<Integer> langLevels = new ArrayList<>();
        List<Skill> skills = new ArrayList<>();
        List<Integer> skillLevels = new ArrayList<>();
        if (e.getEmployeeProfileLanguageList() != null) {
            for (EmployeeProfileLanguage l : e.getEmployeeProfileLanguageList()) {
                if (l.getLevel() > 0) {
                    languages.add(l.getLanguageId());
                    for (int i = l.getLevel(); i < 11; i++) {
                        langLevels.add(i);
                    }

                }

            }

        }
        if (e.getEmployeeProfileSkillList() != null) {
            for (EmployeeProfileSkill l : e.getEmployeeProfileSkillList()) {
                if (l.getLevel() > 0) {
                    skills.add(l.getSkillId());
                    for (int i = l.getLevel(); i < 11; i++) {
                        skillLevels.add(i);
                    }

                }
            }
        }
        if (e.isFilledAnyField()) {
            Page<EmployeeProfile> list = employeeProfileDataInter.findDistinctByUserIdNameLikeOrUserIdSurnameLikeOrUserIdPhoneLikeOrUserIdEmailLikeOrEmployeeProfileLanguageList_LanguageIdInAndEmployeeProfileLanguageList_LevelInOrEmployeeProfileSkillList_SkillIdInAndEmployeeProfileSkillList_LevelIn(
                    e.getUserId().getName(),
                    e.getUserId().getSurname(),
                    e.getUserId().getPhone(),
                    e.getUserId().getEmail(),
                    languages,
                    langLevels,
                    skills,
                    skillLevels, pageable);

            return list;
        } else {
            Page<EmployeeProfile> list = employeeProfileDataInter.findAll(pageable);
            return list;
        }
    }

    @Override
    public EmployeeProfile update(EmployeeProfile employeeProfileTemp) {

        java.sql.Date nowDate = new java.sql.Date(new Date().getTime());

        User loggedInUser = securityServiceInter.getLoggedInUserDetails().getUser();
        loggedInUser = userDataInter.getOne(loggedInUser.getId());
        EmployeeProfile empProfile = loggedInUser.getEmployeeProfile();
        empProfile.setAbout(employeeProfileTemp.getAbout());
        empProfile.setCvPath(employeeProfileTemp.getCvPath());
        empProfile.setExperience(employeeProfileTemp.getExperience());
        empProfile.setGithubPath(employeeProfileTemp.getGithubPath());
        empProfile.setIsLookingForWork(employeeProfileTemp.getIsLookingForWork());
        empProfile.setIsWorking(employeeProfileTemp.getIsWorking());
        empProfile.setLastUpdateDateTime(nowDate);
        empProfile.setLinkedinPath(employeeProfileTemp.getLinkedinPath());
        empProfile.setSpeciality(employeeProfileTemp.getSpeciality());

        List<EmployeeProfileLanguage> epLanguageList = employeeProfileTemp.getEmployeeProfileLanguageList();
        HashSet<EmployeeProfileLanguage> empProfileLanguageHash = new HashSet<>();

        if (epLanguageList != null && epLanguageList.size() > 0) {
            for (EmployeeProfileLanguage epLanguage : epLanguageList) {
                epLanguage.setId(null);
                epLanguage.setEmployeeProfileId(empProfile);
                epLanguage.setInsertDateTime(nowDate);
                empProfileLanguageHash.add(epLanguage);

            }
        }
        List<EmployeeProfileSkill> epSkillList = employeeProfileTemp.getEmployeeProfileSkillList();
        Set<EmployeeProfileSkill> epSkillHashSet = new HashSet<>();

        if (epSkillList != null && epSkillList.size() > 0) {

            for (EmployeeProfileSkill epSkill : epSkillList) {
                if (epSkill == null) continue;
                if (epSkill.getSkillId() == null) continue;
                if (epSkill.getLevel() == null || epSkill.getLevel() == 0) continue;
                epSkill.setId(null);

                Skill skill_ = new Skill();
                Integer id_ = epSkill.getSkillId().getId();
                if (id_ != null && id_ > 0) {
                    skill_ = skillDao.getOne(id_);
                } else {
                    String name_ = epSkill.getSkillId().getName();
                    if (name_ == null || name_.trim().isEmpty()) continue;

                    skill_.setName(name_.trim());
                    skill_.setEnabled(false);
                    skill_.setInsertDateTime(nowDate);
                }
                epSkill.setSkillId(skill_);
                epSkill.setInsertDateTime(nowDate);
                epSkill.setEmployeeProfileId(empProfile);

                epSkillHashSet.add(epSkill);
            }
        }
        empProfile.getEmployeeProfileLanguageList().clear();
        if (epLanguageList != null)
            empProfile.getEmployeeProfileLanguageList().addAll(new ArrayList<>(empProfileLanguageHash));

        empProfile.getEmployeeProfileSkillList().clear();
        if (epSkillList != null)
            empProfile.getEmployeeProfileSkillList().addAll(new ArrayList<>(epSkillHashSet));
        return employeeProfileDataInter.save(empProfile);
    }

    @Override
    public int delete(Integer id) {
        employeeProfileDataInter.deleteById(id);
        return 0;
    }

    @Override
    public EmployeeProfile register(EmployeeProfile employeeProfile) {
        employeeProfile.setApproved(true);
        employeeProfile.setApprovedDateTime(new java.sql.Date(new Date().getTime()));
        employeeProfile.setLastUpdateDateTime(new java.sql.Date(new Date().getTime()));
        employeeProfile.setInsertDateTime(new java.sql.Date(new Date().getTime()));

        User loggedInUser = userDao.getOne(securityService.getLoggedInUserDetails().getUser().getId());
        loggedInUser.setGroupId(new AuthGroup(3));
        employeeProfile.setUserId(loggedInUser);
        List<EmployeeProfileLanguage> epLanguageList = employeeProfile.getEmployeeProfileLanguageList();
        if (epLanguageList != null && epLanguageList.size() > 0) {
            for (EmployeeProfileLanguage epLanguage : epLanguageList) {
                epLanguage.setEmployeeProfileId(employeeProfile);
                epLanguage.setInsertDateTime(new java.sql.Date(new Date().getTime()));
            }
        }
        List<EmployeeProfileSkill> epSkillList = employeeProfile.getEmployeeProfileSkillList();

        List<EmployeeProfileSkill> epSkillFilteredList = new ArrayList<>();

        if (epSkillList != null && epSkillList.size() > 0) {
            Date now_ = new java.sql.Date(new Date().getTime());

            for (EmployeeProfileSkill epSkill : epSkillList) {
                if (epSkill == null) continue;
                if (epSkill.getSkillId() == null) continue;
                if (epSkill.getLevel() == null || epSkill.getLevel() == 0) continue;
                Skill skill_ = new Skill();

                Integer id_ = epSkill.getSkillId().getId();
                if (id_ != null && id_ > 0) {
                    skill_ = skillDao.getOne(id_);
                } else {
                    String name_ = epSkill.getSkillId().getName();
                    if (name_ != null && !name_.trim().isEmpty()) {
                        skill_.setName(name_.trim());
                        skill_.setEnabled(false);
                        skill_.setInsertDateTime(now_);
                    } else {
                        continue;
                    }
                }
//                System.out.println("skill="+skill_);
                epSkill.setSkillId(skill_);
                epSkill.setInsertDateTime(now_);
                epSkill.setEmployeeProfileId(employeeProfile);

                epSkillFilteredList.add(epSkill);
            }
        }
        employeeProfile.setEmployeeProfileLanguageList(epLanguageList);
        employeeProfile.setEmployeeProfileSkillList(epSkillList);
        EmployeeProfile ep = employeeProfileDataInter.save(employeeProfile);

        return ep;
    }

    @Autowired
    private SecurityServiceInter securityServiceInter;

    @Autowired
    UserDataInter userDataInter;

    @Autowired
    EmployeeProjectDaoInter employeeProjectDaoInter;
    @Autowired
    ItProjectDataInter itProjectDataInter;

    public int joinProject(Integer projectId) {
        User loggedInUser = securityServiceInter.getLoggedInUserDetails().getUser();
        loggedInUser = userDataInter.getOne(loggedInUser.getId());
        EmployeeProfile ep = loggedInUser.getEmployeeProfile();
        List<EmployeeProject> projects = ep.getEmployeeProjectList();
        if (projects != null && projects.size() > 0) {
            for (EmployeeProject epr : projects) {
                if (epr.getProjectId().getId() == projectId) {
                    if (epr.getApproved()) {
                        return 2;
                    } else {
                        return 3;
                    }
                }
            }
        }

        Itproject itproject =itProjectDataInter.findById(projectId).get();
        EmployeeProject epr = new EmployeeProject();
        epr.setApproved(false);
        epr.setInsertDateTime(new Date());
        epr.setLastUpdateDateTime(new Date());
        epr.setJoinDateTime(new Date());
        epr.setEmployeeId(ep);
        epr.setProjectId(itproject);

        employeeProjectDaoInter.save(epr);

        return 1;
    }
}
