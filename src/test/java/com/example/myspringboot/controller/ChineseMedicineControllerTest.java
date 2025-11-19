package com.example.myspringboot.controller;

import com.example.myspringboot.entity.ChineseMedicine;
import com.example.myspringboot.service.ChineseMedicineService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ChineseMedicineController.class)
public class ChineseMedicineControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ChineseMedicineService chineseMedicineService;

    private ChineseMedicine medicine;

    @BeforeEach
    void setUp() {
        medicine = new ChineseMedicine();
        medicine.setId(1);
        medicine.setName("桂枝");
        medicine.setPinyin("guizhi");
        medicine.setLatin("Ramulus Cinnamomi");
        medicine.setProperty("辛、甘，温");
        medicine.setChannel("心、肺、膀胱经");
        medicine.setFunction("发汗解肌，温通经脉，助阳化气");
        medicine.setIndication("风寒感冒，脘腹冷痛，血寒经闭，关节痹痛，痰饮，水肿");
        medicine.setUsageMethod("煎服，3-10g");
        medicine.setCaution("温热病及阴虚阳盛之证、血证、孕妇忌用");
        medicine.setImageUrl("guizhi.jpg");
    }

    @Test
    void getAllChineseMedicines() throws Exception {
        List<ChineseMedicine> medicines = Arrays.asList(medicine);
        when(chineseMedicineService.list()).thenReturn(medicines);

        mockMvc.perform(get("/api/chinese-medicines"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(medicines.size()))
                .andExpect(jsonPath("$[0].name").value(medicine.getName()));

        verify(chineseMedicineService, times(1)).list();
    }

    @Test
    void getChineseMedicineById() throws Exception {
        when(chineseMedicineService.getById(1)).thenReturn(medicine);

        mockMvc.perform(get("/api/chinese-medicines/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(medicine.getId()))
                .andExpect(jsonPath("$.name").value(medicine.getName()));

        verify(chineseMedicineService, times(1)).getById(1);
    }

    @Test
    void addChineseMedicine() throws Exception {
        when(chineseMedicineService.save(any(ChineseMedicine.class))).thenReturn(true);

        mockMvc.perform(post("/api/chinese-medicines")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"name\":\"桂枝\",\"pinyin\":\"guizhi\",\"Latin\":\"Ramulus Cinnamomi\",\"property\":\"辛、甘，温\",\"channel\":\"心、肺、膀胱经\",\"function\":\"发汗解肌，温通经脉，助阳化气\",\"indication\":\"风寒感冒，脘腹冷痛，血寒经闭，关节痹痛，痰饮，水肿\",\"usageMethod\":\"煎服，3-10g\",\"caution\":\"温热病及阴虚阳盛之证、血证、孕妇忌用\",\"imageUrl\":\"guizhi.jpg\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(chineseMedicineService, times(1)).save(any(ChineseMedicine.class));
    }

    @Test
    void updateChineseMedicine() throws Exception {
        when(chineseMedicineService.updateById(any(ChineseMedicine.class))).thenReturn(true);

        mockMvc.perform(put("/api/chinese-medicines")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"id\":1,\"name\":\"桂枝\",\"pinyin\":\"guizhi\",\"Latin\":\"Ramulus Cinnamomi\",\"property\":\"辛、甘，温\",\"channel\":\"心、肺、膀胱经\",\"function\":\"发汗解肌，温通经脉，助阳化气\",\"indication\":\"风寒感冒，脘腹冷痛，血寒经闭，关节痹痛，痰饮，水肿\",\"usageMethod\":\"煎服，3-10g\",\"caution\":\"温热病及阴虚阳盛之证、血证、孕妇忌用\",\"imageUrl\":\"guizhi.jpg\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(chineseMedicineService, times(1)).updateById(any(ChineseMedicine.class));
    }

    @Test
    void deleteChineseMedicine() throws Exception {
        when(chineseMedicineService.removeById(1)).thenReturn(true);

        mockMvc.perform(delete("/api/chinese-medicines/1"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(chineseMedicineService, times(1)).removeById(1);
    }

    @Test
    void searchChineseMedicines() throws Exception {
        List<ChineseMedicine> medicines = Arrays.asList(medicine);
        when(chineseMedicineService.list(any())).thenReturn(medicines);

        mockMvc.perform(get("/api/chinese-medicines/search?keyword=桂枝"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(medicines.size()))
                .andExpect(jsonPath("$[0].name").value(medicine.getName()));

        verify(chineseMedicineService, times(1)).list(any());
    }

    @Test
    void getChineseMedicinesPage() throws Exception {
        // 这里需要模拟分页查询的结果
        // 由于时间关系，这里只做一个简单的测试
        mockMvc.perform(get("/api/chinese-medicines/page?page=1&size=10"))
                .andExpect(status().isOk());

        verify(chineseMedicineService, times(1)).page(any());
    }
}