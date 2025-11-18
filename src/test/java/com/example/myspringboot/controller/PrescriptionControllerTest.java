package com.example.myspringboot.controller;

import com.example.myspringboot.entity.Prescription;
import com.example.myspringboot.service.PrescriptionService;
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

@WebMvcTest(PrescriptionController.class)
public class PrescriptionControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private PrescriptionService prescriptionService;

    private Prescription prescription;

    @BeforeEach
    void setUp() {
        prescription = new Prescription();
        prescription.setId(1);
        prescription.setName("桂枝汤");
        prescription.setPinyin("guizhitang");
        prescription.setSource("伤寒论");
        prescription.setCategory("解表剂");
        prescription.setComposition("桂枝三两，芍药三两，甘草二两，生姜三两，大枣十二枚");
        prescription.setDosage("水煎服");
        prescription.setFunction("解肌发表，调和营卫");
        prescription.setIndication("外感风寒表虚证");
        prescription.setExplanation("桂枝汤是伤寒论第一方");
        prescription.setSyndromes("脉浮缓，自汗出");
    }

    @Test
    void getAllPrescriptions() throws Exception {
        List<Prescription> prescriptions = Arrays.asList(prescription);
        when(prescriptionService.list()).thenReturn(prescriptions);

        mockMvc.perform(get("/api/prescriptions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(prescriptions.size()))
                .andExpect(jsonPath("$[0].name").value(prescription.getName()));

        verify(prescriptionService, times(1)).list();
    }

    @Test
    void getPrescriptionById() throws Exception {
        when(prescriptionService.getById(1)).thenReturn(prescription);

        mockMvc.perform(get("/api/prescriptions/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(prescription.getId()))
                .andExpect(jsonPath("$.name").value(prescription.getName()));

        verify(prescriptionService, times(1)).getById(1);
    }

    @Test
    void searchPrescriptions() throws Exception {
        List<Prescription> prescriptions = Arrays.asList(prescription);
        when(prescriptionService.list(any())).thenReturn(prescriptions);

        mockMvc.perform(get("/api/prescriptions/search?keyword=桂枝汤"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(prescriptions.size()))
                .andExpect(jsonPath("$[0].name").value(prescription.getName()));

        verify(prescriptionService, times(1)).list(any());
    }

    @Test
    void getPrescriptionsByCategory() throws Exception {
        List<Prescription> prescriptions = Arrays.asList(prescription);
        when(prescriptionService.list(any())).thenReturn(prescriptions);

        mockMvc.perform(get("/api/prescriptions/category/解表剂"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(prescriptions.size()))
                .andExpect(jsonPath("$[0].name").value(prescription.getName()));

        verify(prescriptionService, times(1)).list(any());
    }

    @Test
    void addPrescription() throws Exception {
        when(prescriptionService.save(any(Prescription.class))).thenReturn(true);

        mockMvc.perform(post("/api/prescriptions")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"name\":\"桂枝汤\",\"pinyin\":\"guizhitang\",\"source\":\"伤寒论\",\"category\":\"解表剂\",\"composition\":\"桂枝三两，芍药三两，甘草二两，生姜三两，大枣十二枚\",\"dosage\":\"水煎服\",\"function\":\"解肌发表，调和营卫\",\"indication\":\"外感风寒表虚证\",\"explanation\":\"桂枝汤是伤寒论第一方\",\"syndromes\":\"脉浮缓，自汗出\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(prescriptionService, times(1)).save(any(Prescription.class));
    }

    @Test
    void updatePrescription() throws Exception {
        when(prescriptionService.updateById(any(Prescription.class))).thenReturn(true);

        mockMvc.perform(put("/api/prescriptions")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"id\":1,\"name\":\"桂枝汤\",\"pinyin\":\"guizhitang\",\"source\":\"伤寒论\",\"category\":\"解表剂\",\"composition\":\"桂枝三两，芍药三两，甘草二两，生姜三两，大枣十二枚\",\"dosage\":\"水煎服\",\"function\":\"解肌发表，调和营卫\",\"indication\":\"外感风寒表虚证\",\"explanation\":\"桂枝汤是伤寒论第一方\",\"syndromes\":\"脉浮缓，自汗出\"}"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(prescriptionService, times(1)).updateById(any(Prescription.class));
    }

    @Test
    void deletePrescription() throws Exception {
        when(prescriptionService.removeById(1)).thenReturn(true);

        mockMvc.perform(delete("/api/prescriptions/1"))
                .andExpect(status().isOk())
                .andExpect(content().string("true"));

        verify(prescriptionService, times(1)).removeById(1);
    }

    @Test
    void getPrescriptionsPage() throws Exception {
        mockMvc.perform(get("/api/prescriptions/page?page=1&size=10"))
                .andExpect(status().isOk());

        verify(prescriptionService, times(1)).page(any());
    }
}