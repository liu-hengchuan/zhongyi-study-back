package com.example.myspringboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.myspringboot.entity.PulseDiagnosis;
import com.example.myspringboot.service.PulseDiagnosisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 脉诊控制器
 */
@RestController
@RequestMapping("/api/pulse-diagnosis")
public class PulseDiagnosisController {
    @Autowired
    private PulseDiagnosisService pulseDiagnosisService;

    /**
     * 获取所有脉象
     * @return 脉象列表
     */
    @GetMapping
    public List<PulseDiagnosis> getAllPulseDiagnosis() {
        return pulseDiagnosisService.list();
    }

    /**
     * 分页查询脉象
     * @param page 页码
     * @param size 每页大小
     * @return 分页结果
     */
    @GetMapping("/page")
    public Page<PulseDiagnosis> getPulseDiagnosisPage(@RequestParam(defaultValue = "1") Integer page,
                                                      @RequestParam(defaultValue = "10") Integer size) {
        Page<PulseDiagnosis> pulsePage = new Page<>(page, size);
        return pulseDiagnosisService.page(pulsePage, null);
    }

    /**
     * 根据ID获取脉象
     * @param id 脉象ID
     * @return 脉象
     */
    @GetMapping("/{id}")
    public PulseDiagnosis getPulseDiagnosisById(@PathVariable Integer id) {
        return pulseDiagnosisService.getById(id);
    }

    /**
     * 新增脉象
     * @param pulseDiagnosis 脉象
     * @return 是否成功
     */
    @PostMapping
    public boolean addPulseDiagnosis(@RequestBody PulseDiagnosis pulseDiagnosis) {
        return pulseDiagnosisService.save(pulseDiagnosis);
    }

    /**
     * 更新脉象
     * @param pulseDiagnosis 脉象
     * @return 是否成功
     */
    @PutMapping
    public boolean updatePulseDiagnosis(@RequestBody PulseDiagnosis pulseDiagnosis) {
        return pulseDiagnosisService.updateById(pulseDiagnosis);
    }

    /**
     * 删除脉象
     * @param id 脉象ID
     * @return 是否成功
     */
    @DeleteMapping("/{id}")
    public boolean deletePulseDiagnosis(@PathVariable Integer id) {
        return pulseDiagnosisService.removeById(id);
    }
}
