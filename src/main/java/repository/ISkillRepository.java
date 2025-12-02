package repository;

import model.Skill;
import java.util.List;

public interface ISkillRepository {
    List<Skill> getAllSkills();
    Skill getSkillById(String id);
    void addSkill(Skill skill);
    void updateSkill(Skill skill);
    void deleteSkill(String id);
    boolean existsByName(String name);
}